Return-Path: <linux-tip-commits+bounces-2126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB09604D1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525822841BA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Aug 2024 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95570158D66;
	Tue, 27 Aug 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFZLaluy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tI1x+4wM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0E156883;
	Tue, 27 Aug 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748492; cv=none; b=hLZj1PRMeUe3hZk219qja5cHlQrxUZrmURKTBQgrPHR2fN/3hih+l9JW0tp8UbTCCGYw1TMg398UiajIRobdmcWqzieOsftIYV4s5fuhOtga9Ntvxk3hnkzaCoBOcBagPosZOc2rSoODZeZLZpouM8nRK3L2/j4hmW6NV1vzFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748492; c=relaxed/simple;
	bh=KGdNHCejzPSsN/WfVtEMp4AR/Wk9t89iFWv+qt1CmR4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cc2i/tzm9hhv1Kx60XxnDPE1JO2rI+PQXytKO9QmIfFBVSxmrFkNpOw+/VKDsg1+xuln5nGUIQ9a4OBSraHuNZPrn6QB1cLYFMAtBQis62QV33ra1BXK1qQqzXz12TTLFxKGgZhNzjEmlUhxsgPXNFVkbamC3QfgvtUyNtQxgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFZLaluy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tI1x+4wM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 08:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724748487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVmifEH+2GQeHB4/kRvFMI7Tqf9Lo5lVm0RepCDGoT0=;
	b=iFZLaluyLhCx3Dd4Ks7TUeaFeJguKh5hd1U3L72hsIFC8TajpEMN6TgdLhYMAgStnNQcNx
	hlyawXiMU9MdB/niTmdBR9IpB25QuP2ubHtbHSHxkR0AtoXkiDNL2hFYS1OO5MUKPrnszw
	HezEe9yd7qwpbNxLN6gyrT3Sgq6fiQEi8gg9RihWB7tJGTYTRz6kp1ZakzqF4QMsUyz70j
	qebWir+USp88mJPUG958Zdyhw6QwGXxv8Sv+GK+r6WU1mtxGVspakRJb9R836DmBb9MYDd
	Tn7txmDwCuPTUNkdJnaigUNaMdNU2SZjG3p1i1j5LvFXD6Myi0e2rvUBIEPcQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724748487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVmifEH+2GQeHB4/kRvFMI7Tqf9Lo5lVm0RepCDGoT0=;
	b=tI1x+4wMrYULr0Rj8s2dItpBnNco07DjUbW/de0xlfmcSNvyT8wGiRbdKBf6Ut1MjxyXs/
	gCgtJguQNa4TyyCg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Replace dev_dbg() with pr_debug()
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731150811.156771-2-nikunj@amd.com>
References: <20240731150811.156771-2-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172474848742.2215.3001369018710025296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     dc6d20b900b72bea89ebd8154ba9bde1029f330b
Gitweb:        https://git.kernel.org/tip/dc6d20b900b72bea89ebd8154ba9bde1029f330b
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 31 Jul 2024 20:37:52 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Aug 2024 10:22:20 +02:00

virt: sev-guest: Replace dev_dbg() with pr_debug()

In preparation for moving code to arch/x86/coco/sev/core.c, replace
dev_dbg with pr_debug.

No functional change.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Peter Gonda <pgonda@google.com>
Link: https://lore.kernel.org/r/20240731150811.156771-2-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 6fc7884..7d343f2 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -296,8 +296,9 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, 
 	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
 	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
 
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+	pr_debug("response [seqno %lld type %d version %d sz %d]\n",
+		 resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version,
+		 resp_hdr->msg_sz);
 
 	/* Copy response from shared memory to encrypted memory. */
 	memcpy(resp, snp_dev->response, sizeof(*resp));
@@ -343,8 +344,8 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	if (!hdr->msg_seqno)
 		return -ENOSR;
 
-	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
-		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+	pr_debug("request [seqno %lld type %d version %d sz %d]\n",
+		 hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
 
 	return __enc_payload(snp_dev, req, payload, sz);
 }

