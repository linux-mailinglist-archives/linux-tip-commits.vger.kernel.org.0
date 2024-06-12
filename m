Return-Path: <linux-tip-commits+bounces-1382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB53905CBC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6451F250FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA584D39;
	Wed, 12 Jun 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6EcJCUA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F74izOzU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1EF84A50;
	Wed, 12 Jun 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223867; cv=none; b=GMNncu2Sfkpe29e2bURE5Gdk0BRa9FNaUrRIDbRqsysXRlLDCNd1vM68snT4YcbralTbms1vSkNlEGjtVdyBmC38ZFuiJtRHq1IYzFUaNBxxAl3KhFsFxhjcv5B4RuMTEB/8AQ+OhliVYS7O8YD3EbuPrP1JT/4Y45iytK1+qqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223867; c=relaxed/simple;
	bh=yjWkhxs5kUTi6CYrOT0J3zw9KEWkho0XRWlCYLaAA5Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r4fyFG4gfwCp6+Ly9yUCre/EIK7UVi/1voA73VNpFrUPsYvfdIZneM8SEuGuJHdZo6LVGvdHqe+2qnjvf3sJXBCfHxgm15rCn0ruvbv43lXAcpAyqrLGYa5ilODLUFBlL1aN95mdh4nlGytqz91IH6cEpKdJ8cEZfWglR8KTql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W6EcJCUA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F74izOzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwVOHysEGr846iN4zNF25RAqMaPqe7jfEOPp/zwruw8=;
	b=W6EcJCUAgxDaQHnXTu8L4qHXN4tYjGjQI4bLpqKdg+PWuTWo++a6SJxvGOv9bQ70Om8oih
	kKPSzpoaPAJsaswd+CsSp6/XAKyOVyMZM/LSdMdBu62NRsNgW/ZcozlaxulrLFl9/p15iC
	S48J5PjrbUV2KDUlUfzMap7eUrm2crjhWrLmsToO5tpzJeafPz5tD2n4/buAswGp2JffRj
	+Ebbu1nxctwS/3aTda7E/wFJrjSIifpJkO4wFTtQn/JPb2yCHj1nt+cGh0EPEMr+sfyzsL
	uqho0DOKjQQRs6zZ/uow1utbehK0hC01zAgCmhUOnAoHYwpUh5ih5TSg2b5nGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223864;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwVOHysEGr846iN4zNF25RAqMaPqe7jfEOPp/zwruw8=;
	b=F74izOzUfdHo3BBtu8a45QTUUR1edL9+910wh1bY6jO0OnBfrPjc0AU8AWLEG8B+m1aQxC
	1/H/2E8aYdEV71Bg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] hwmon: (k10temp) Define a helper function to read CCD
 temperature
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-5-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-5-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386382.10875.6648306533264978895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     cc66126fd317a70d8612a8356ad512a1539abd75
Gitweb:        https://git.kernel.org/tip/cc66126fd317a70d8612a8356ad512a1539abd75
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:12:58 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:39:29 +02:00

hwmon: (k10temp) Define a helper function to read CCD temperature

The CCD temperature register is read in two places. These reads are done
using an AMD SMN access, and a number of parameters are needed for the
operation.

Move the SMN access and parameter gathering into a helper function in order to
simplify the code flow. This also has a benefit of centralizing the hardware
register access in a single place in case fixes or special decoding is required.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-5-ffde21931c3f@amd.com
---
 drivers/hwmon/k10temp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 6cad35e..315c52d 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -158,6 +158,13 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 		*regval = 0;
 }
 
+static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
+{
+	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
+
+	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval);
+}
+
 static long get_raw_temp(struct k10temp_data *data)
 {
 	u32 regval;
@@ -223,9 +230,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-					   &regval);
+			ret = read_ccd_temp_reg(data, channel - 2, &regval);
 
 			if (ret)
 				return ret;
@@ -397,8 +402,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 		 * the register value. And this will incorrectly pass the TEMP_VALID
 		 * bit check.
 		 */
-		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+		if (read_ccd_temp_reg(data, i, &regval))
 			continue;
 
 		if (regval & ZEN_CCD_TEMP_VALID)

