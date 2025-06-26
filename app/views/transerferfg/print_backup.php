<?php

class FPDF_AutoWrapTable extends FPDF {
    private $data = array();
    private $options = array(
        'filename' => '',
        'destinationfile' => '',
        'paper_size' => 'F4',
        'orientation' => 'P'
    );

    private $addres1;
    private $addres2;

    function __construct($data = array(), $options = array()) {
        parent::__construct();
        $this->data = $data;
        $this->options = $options;
    }

    public function rptDetailData() {
        date_default_timezone_set('Asia/Jakarta');
        $border = 0;
        $this->AddPage();
        $this->SetAutoPageBreak(true, 60);
        $this->AliasNbPages();
        $left = 25;

        // Header
        $SoTransacID = "";
        $Shipdate = "";
        $SOEntryDesc = "";
        $CustCoName = "";
        $custname = "";
        $custaddress = "";
        $subtotal = "";
        $tax = "";
        $total = "";

        foreach ($this->data as $items) {
            $SoTransacID = $items['SoTransacID'];
            $Shipdate = $items['Shipdate'];
            $SOEntryDesc = $items['SOEntryDesc'];
            $CustCoName = $items['CustCoName'];
            $custname = $items['CustName'];
            $custaddress = $items['CustAddress'];
            $subtotal = $items["Sub_total"];
            $tax = $items["Tax"];
            $total = $items["Total"];
        }

        // Set font to Arial, bold, 11pt
        $this->SetFont('Arial', 'B', 11);
        $this->Cell(128, 5, $custname, 0, 0);
        $this->Cell(59, 5, 'MUTASI BARANG PT. BMN', 0, 1); // End of line

        // Set font to Arial, regular, 10pt
        $this->SetFont('Arial', '', 10);
        $y = $this->GetY();
        $x = $this->GetX();
        $width = 108;
        $this->MultiCell($width, 5, $custaddress, 0, 'L', FALSE);
        $this->SetXY($x + $width, $y);
        $this->MultiCell(20, 5, '', 0, 'L', FALSE);
        $this->SetXY($x + $width + 20, $y);
        $this->MultiCell(44, 5, 'NO   : ' . $SoTransacID . ' Date : ' . $Shipdate, 0, 'L', FALSE);

        $this->Cell(0, 2, '', 0, 1, 'C');
        $this->Cell(189, 3, '', 0, 1); // End of line

        $this->SetFont('Arial', '', 8);
        $this->Cell(130, 5, 'UP : ' . $CustCoName, 0, 0);
        $this->Cell(60, 5, 'Page: ' . $this->PageNo() . ' of {nb}', 0, 1, 'R'); // 'R' untuk rata kanan

        // Invoice contents
        $this->SetLineWidth(0.4);
        $this->Cell(0, 0.2, '', 1, 1, 'C');
        $this->Ln(1);

        $left = $this->GetX();
        $h = 6;

        // Column headers
        $this->SetX($left += 0);
        $this->Cell(8, $h, 'No', 0, 0, 'C');
        $this->SetX($left += 8);
        $this->Cell(18, $h, 'PartId', 0, 0, 'L');
        $this->SetX($left += 18);
        $this->Cell(85, $h, 'Part Name', 0, 0, 'L');

        // Save Y position for aligning cell height
        $y = $this->GetY();
        $x = $left += 85; // Last X position

        // Column "Qty"
        $this->SetXY($x, $y);
        $this->MultiCell(15, 4, 'Qty   (pcs)', 0, 'R');

        // Column "Price"
        $this->SetXY($x += 15, $y);
        $this->MultiCell(22, 4, 'Price (Rp.) (pcs)', 0, 'R');

        // Column "Disc"
        $this->SetXY($x += 22, $y);
        $this->MultiCell(18, 4, 'Disc (%) (pcs)', 0, 'R');

        // Column "Amount"
        $this->SetXY($x += 18, $y);
        $this->MultiCell(22, 4, 'Amount (Rp.) (pcs)', 0, 'R');

        // Move Y position manually to the next line
        $this->SetY($y + 8); // 4*2 baris (jika 2 baris teks)

        // Underline header
        $this->Cell(0, 2, '', 0, 1, 'C');
        $this->Cell(0, 0.1, '', 1, 1, 'C');

        // Format table content
        $this->SetFont('Arial', '', 8);
        $this->SetDrawColor(255, 255, 255);
        $this->SetWidths([8, 18, 85, 15, 22, 18, 22]);
        $this->SetAligns(['C', 'L', 'L', 'R', 'R', 'R', 'R']);

        $this->SetFillColor(255);
        $this->SetLineWidth(0.2);
        $this->Ln(2);

        $no = 1;

        foreach ($this->data as $baris) {
            $detail = $baris["detail"];
            foreach ($detail as $item) {
                $this->Row([
                    $no++,
                    $item['PartId'],
                    $item['PartName'],
                    $item["Quantity"],
                    $item["price"],
                    $item["discount"],
                    $item["amount"],
                ]);
            }
        }

        // Determine starting position for lines
        $this->Ln(2);
        $this->SetDrawColor(0, 0, 0);
        $this->SetLineWidth(0.4);
        $this->Cell(0, 0.2, '', 1, 1, 'C');

        // Hitung tinggi keterangan Notes
        $notesHeight = $this->NbLines(85, $SOEntryDesc) * 5; // 5 = tinggi baris

        // Cek apakah masih muat di halaman
        if ($this->GetY() + $notesHeight + 20 > $this->PageBreakTrigger) {
            $this->AddPage();
        }
        $currentY = $this->GetY(); // Get position after total
        $this->SetXY(10, $currentY); // Start from X=10 & Y=now
        $this->SetFont('Arial', '', 8);
        $this->MultiCell(11, 5, 'Notes ', 0, 'L', FALSE);
        $this->SetXY(21, $currentY);
        $this->MultiCell(3, 5, ':', 0, 'L', FALSE);
        $this->SetXY(24, $currentY);
        $notesHeight = $this->GetMultiCellHeight(85, 5, $SOEntryDesc);
        $this->MultiCell(85, 5, $SOEntryDesc, 1, 'L', false);

        // Add spacing after notes
        $this->Ln(5); // Add space after notes

        // Print subtotal
        $x = 145;
        $this->SetXY($x, $currentY);
        $this->Cell(30, 5, 'Sub Total', 1, 0, 'L');
        $this->Cell(3, 5, ':', 0, 0, 'C');
        $this->Cell(22, 5, $subtotal, 0, 1, 'R');

        // Print tax
        $y2 = $this->GetY();
        $this->SetXY($x, $y2);
        $this->Cell(30, 5, 'Tax', 0, 0, 'L');
        $this->Cell(3, 5, ':', 0, 0, 'C');
        $this->Cell(22, 5, $tax, 0, 1, 'R');

        // Print total
        $y3 = $this->GetY();
        $this->SetXY($x, $y3);
        $this->Cell(30, 5, 'Total', 0, 0, 'L');
        $this->Cell(3, 5, ':', 0, 0, 'C');
        $this->Cell(22, 5, $total, 0, 1, 'R');

        // For signatures
        
       $newY = $currentY + $notesHeight+5; 
        $this->SetY($newY); // This ensures proper spacing after notes
        $this->SetFont('Arial', '', 8);
        $this->Cell(35, 5, 'Disiapkan Oleh,', 0, 0, 'C');
        $this->Cell(60, 5, 'Disetujui Oleh,', 0, 0, 'C');
        $this->Cell(55, 5, 'Dikirim Oleh,', 0, 0, 'C');
        $this->Cell(60, 5, 'Diterima Oleh,', 0, 1, 'C');

        $this->Cell(0, 12, '', 0, 1, 'C');
        $this->Cell(0, 2, '', 0, 1, 'C');

        $this->Cell(35, 5, '(___________________)', 0, 0, 'C');
        $this->Cell(60, 5, '(___________________)', 0, 0, 'C');
        $this->Cell(55, 5, '(___________________)', 0, 0, 'C');
        $this->Cell(60, 5, '(___________________)', 0, 1, 'C');
        $this->Cell(0, 5, '', 0, 1, 'C');
        $this->Cell(35, 5, date('d/m/Y H:i:s'), 0, 1, 'C');
        
    }

    private function GetMultiCellHeight($w, $h, $txt) {
    // Calculate how many lines the text will take
    $nb = $this->NbLines($w, $txt);
    return $h * $nb;
}

            function Footer() {
                $this->SetY(-5); // artinya 10 pt (≈3.5 mm) dari bawah
                $this->SetFont('Arial', 'I', 6); // kecilkan ukuran font
                $this->Cell(0, 5, 'Page ' . $this->PageNo() . ' of {nb}', 0, 0, 'R');
            }


    public function printPDF() {
        if ($this->options['paper_size'] == "F4") {
            $a = 8.3 * 72; // 1 inch = 72 pt
            $b = 13.0 * 72;
            new FPDF($this->options['orientation'], "pt", array($a, $b));
        } else {
            $this->FPDF($this->options['orientation'], "pt", $this->options['paper_size']);
        }

        $this->SetAutoPageBreak(false);
        $this->AliasNbPages();
        $this->SetFont("helvetica", "B", 10);
        $this->rptDetailData();
        $this->Output($this->options['filename'], $this->options['destinationfile']);
    }

    private $widths;
    private $aligns;

    function SetWidths($w) {
        // Set the array of column widths
        $this->widths = $w;
    }

    function SetAligns($a) {
        // Set the array of column alignments
        $this->aligns = $a;
    }

    function Row($data) {
        // Calculate the height of the row
        $nb = 0;
        for ($i = 0; $i < count($data); $i++)
            $nb = max($nb, $this->NbLines($this->widths[$i], $data[$i]));

        $h = 8 * $nb;

        // Issue a page break first if needed
        $this->CheckPageBreak($h);

        // Draw the cells of the row
        for ($i = 0; $i < count($data); $i++) {
            $w = $this->widths[$i];
            $a = isset($this->aligns[$i]) ? $this->aligns[$i] : 'L';
            // Save the current position
            $x = $this->GetX();
            $y = $this->GetY();

            // Draw the border
            $this->Rect($x, $y, $w, $h);

            // Print the text
            $this->MultiCell($w, 8, $data[$i], 0, $a);

            // Put the position to the right of the cell
            $this->SetXY($x + $w, $y);
        }

        // Go to the next line
        $this->Ln($h);
    }

    function CheckPageBreak($h) {
        // If the height h would cause an overflow, add a new page immediately
        if ($this->GetY() + $h > $this->PageBreakTrigger)
            $this->AddPage($this->CurOrientation);
    }

    function NbLines($w, $txt) {
        // Computes the number of lines a MultiCell of width w will take
        $cw = &$this->CurrentFont['cw'];
        if ($w == 0)
            $w = $this->w - $this->rMargin - $this->x;
        $wmax = ($w - 2 * $this->cMargin) * 1000 / $this->FontSize;
        $s = str_replace("\r", '', $txt);
        $nb = strlen($s);
        if ($nb > 0 and $s[$nb - 1] == "\n")
            $nb--;
        $sep = -1;
        $i = 0;
        $j = 0;
        $l = 0;
        $nl = 1;

        while ($i < $nb) {
            $c = $s[$i];
            if ($c == "\n") {
                $i++;
                $sep = -1;
                $j = $i;
                $l = 0;
                $nl++;
                continue;
            }
            if ($c == ' ')
                $sep = $i;
            $l += $cw[$c];
            if ($l > $wmax) {
                if ($sep == -1) {
                    if ($i == $j)
                        $i++;
                } else
                    $i = $sep + 1;
                $sep = -1;
                $j = $i;
                $l = 0;
                $nl++;
            } else
                $i++;
        }
        return $nl;
    }

    private function replace_name($data) {
        $replace = str_replace("&amp;", "", $data);
        return $replace;
    }
} // End of class

// Options
$options = array(
    'filename' => '', // File name for saving, leave empty for output to browser
    'destinationfile' => '', // I=inline browser (default), F=local file, D=download
    'paper_size' => 'F4', // Paper size: F4, A3, A4, A5, Letter, Legal
    'orientation' => 'P' // Orientation: P=portrait, L=landscape
);

$tabel = new FPDF_AutoWrapTable($data, $options);
$tabel->printPDF();
?>
