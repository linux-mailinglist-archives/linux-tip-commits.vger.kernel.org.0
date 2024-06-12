Return-Path: <linux-tip-commits+bounces-1381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD24905CBB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518F71F25108
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D83284D0E;
	Wed, 12 Jun 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Omu5T1oz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MY4HrY/R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6584A57;
	Wed, 12 Jun 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223866; cv=none; b=tPzYyOWOYKfCAnT0x+++W5pBtVdvtl63xUAR6fpF9/iVRnnJhyvjEONuSgnyOwix592+fceyz3/vvXDo0y2KxQRJ14m2dAWjRemfBlzedqGv/uCTyFfE7ddSNfbeaSSJDF3coDHHpi1KZOoGm82o9rvL8imVwIOWFW1yRT4fw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223866; c=relaxed/simple;
	bh=LIyKfRfRz3WyKm4vpCmSWRaMedgilHhPbcrB9c9g/0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W6GHwgSORKkHOIMqhBzopbnWc0YIBJD9G3B+5Dpb2NM8Q6WjjClHb5xAyiPlqjHvhJj9fc6tt0d3gcdJUe4vvFFN1CskIgtXDtUGvz14Gbu7Y4WOOLUzzeBhH7z4j+3WaCsWlnBbzVttwa1jjqwjHWPRwYFoH0mO3gw1P1vSReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Omu5T1oz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MY4HrY/R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8uc29jjHlTSS415RpyJfZ+whRW4voX8fLpotz5hIhg=;
	b=Omu5T1oz5riwasMDLhZ4SNQwQZjIRrx0PMjgIWjQFM5gtEMkdb+HoyvV88CmnBnTL2IUoO
	lKwfuUDIcPl5jqF8vQjXrpmf2KQyz5FxSq4J99Hs6jPXHjR12ok590cPDRHPV7VZ2GDhdc
	lr6+9IXs9NQvd+taYmmy/yicnmgZSprbDEHs7RY22KHvPVwW3Ab83yVffGnmwZwM6AWt+C
	FPdfElQ4jQwzOvIY+e75f6ZY4GhfKyHmz3JrZ2hdk/tgGu+c8yE1mlhTbjtO4sisCVYQKx
	3AaWSOznkbnEScrWnQJv29ogqU6SKF3FWs6SSV2e1G0uFDQCcgJEQF3XrLVdxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8uc29jjHlTSS415RpyJfZ+whRW4voX8fLpotz5hIhg=;
	b=MY4HrY/RALyxCBvZASJhIfOPeYEEnK7MQH9zCSepZnzTp7+Fxvt6O9rCRFaofU4g4E0BdT
	v+nkCmxss4GkNCDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-6-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-6-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386356.10875.3642928193180867372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a8bc4165d237f4a6bddbab55d2b6592b87341f0a
Gitweb:        https://git.kernel.org/tip/a8bc4165d237f4a6bddbab55d2b6592b87341f0a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:12:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:39:49 +02:00

hwmon: (k10temp) Reduce k10temp_get_ccd_support() parameters

Currently, k10temp_get_ccd_support() takes as input "pdev" and "data".  However,
"pdev" is already included in "data". Furthermore, the "pdev" parameter is no
longer used in k10temp_get_ccd_support(), since its use was moved into
read_ccd_temp_reg().

Drop the "pdev" input parameter as it is no longer needed.

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-6-ffde21931c3f@amd.com
---
 drivers/hwmon/k10temp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 315c52d..6deb272 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -385,8 +385,7 @@ static const struct hwmon_chip_info k10temp_chip_info = {
 	.info = k10temp_info,
 };
 
-static void k10temp_get_ccd_support(struct pci_dev *pdev,
-				    struct k10temp_data *data, int limit)
+static void k10temp_get_ccd_support(struct k10temp_data *data, int limit)
 {
 	u32 regval;
 	int i;
@@ -456,18 +455,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 4);
+			k10temp_get_ccd_support(data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x60:	/* Renoir */
 		case 0x68:	/* Lucienne */
 		case 0x71:	/* Zen2 */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
@@ -481,21 +480,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x40 ... 0x4f:	/* Yellow Carp */
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x60 ... 0x6f:
 		case 0x70 ... 0x7f:
 			data->ccd_offset = 0x308;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 12);
+			k10temp_get_ccd_support(data, 12);
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x1a) {

