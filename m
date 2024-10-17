Return-Path: <linux-tip-commits+bounces-2499-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB4F9A2191
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A117D1F248E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542D01DD0EF;
	Thu, 17 Oct 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VCrTjuEL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gnive9Wh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971E1DB527;
	Thu, 17 Oct 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166194; cv=none; b=GpR0LDDOCEbfHVKFYSIADBamfTtP1VNdb+RLNhX/HN3K23dRF/h95WuuV0wY77rtVKxsLiVBnYWvU3ZZ79lnxljjW61Nplnb7aUgjEETCFPfAo8Sc9dKAHVbhuWDO2WQIs9QdUz8qJL5D61g8AluB9VrAwlcUaitlL/05WQRpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166194; c=relaxed/simple;
	bh=DNrn2OjmuuOfiLcqcUeKUZ9rFY+cHgfotfBfmq5ktew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WsTJ2pWH/AOgeT/tL4qS3ymUrtnNF+z7/tBfCafSaLZI8YP8tryTBryb9338Ux4gOw0xyMKYhZCEtHIlwpFtElBLiFDH2LMvUkEOsPNTGdKlD2o1/PPmohtWm92OmWRkmmaSEj0Iq28EtUVFNTSI0YWOltrfVOykZMqfmyHqJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VCrTjuEL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gnive9Wh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZ/7faYS8H9FlIxqrb6us1u89riR6fF70G7FXHo4Dak=;
	b=VCrTjuEL7RncmNFheHK8/F5HmP0Rs2nz5gR61PHSdAMB70fTcw8V3uBnTF1BabEJQCSwU/
	A8g8wUDR3UBrz16QHJwjTE1DXdYY3kgS2q05gu6XXQkxIZQC2qe9didMXiZEzGBkKipJKl
	+PJ3ePmSBCD4cfzxBfJXEEEoKRp4ZWebJ0tH4e3eW2K6X6oKp+ryjqG9ENGgFcER8Df0PS
	clHJMCEFdSesUOZjW8G9mbPkLW3Sl7qO+3bTpeFdrJuh+/n1O6Hgsfog3FMsbJsC8lZvHC
	ubOIVX+Mhxi1Yj5ELCB0gxjp63EPiegSeFQgNPPUltKbrceGKCHPky2I66LamQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZ/7faYS8H9FlIxqrb6us1u89riR6fF70G7FXHo4Dak=;
	b=Gnive9Why8dyI/mVrb4G0XetYIrx/LspI5+zTIyn6dtxVC55ObtMr2Fx4zac1ia4z7iV8D
	72afCKTGHKVgxVBA==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Reduce the scope of SNP command mutex
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-6-nikunj@amd.com>
References: <20241009092850.197575-6-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916618748.1442.663318949309592421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ae596615d93dedbdfffbe383f821bea5c5289576
Gitweb:        https://git.kernel.org/tip/ae596615d93dedbdfffbe383f821bea5c5289576
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:36 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:35:28 +02:00

virt: sev-guest: Reduce the scope of SNP command mutex

The SNP command mutex is used to serialize access to the shared buffer,
command handling, and message sequence number.

All shared buffer, command handling, and message sequence updates are done
within snp_send_guest_request(), so moving the mutex to this function is
appropriate and maintains the critical section.

Since the mutex is now taken at a later point in time, remove the lockdep
checks that occur before taking the mutex.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241009092850.197575-6-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 35 +++++-------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 2a1b542..1bddef8 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -345,6 +345,14 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
 	u64 seqno;
 	int rc;
 
+	guard(mutex)(&snp_cmd_mutex);
+
+	/* Check if the VMPCK is not empty */
+	if (is_vmpck_empty(snp_dev)) {
+		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
+		return -ENOTTY;
+	}
+
 	/* Get message sequence and verify that its a non-zero */
 	seqno = snp_get_msg_seqno(snp_dev);
 	if (!seqno)
@@ -401,8 +409,6 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	struct snp_guest_req req = {};
 	int rc, resp_len;
 
-	lockdep_assert_held(&snp_cmd_mutex);
-
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
@@ -449,8 +455,6 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
 	u8 buf[64 + 16];
 
-	lockdep_assert_held(&snp_cmd_mutex);
-
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
@@ -501,8 +505,6 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
 
-	lockdep_assert_held(&snp_cmd_mutex);
-
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
@@ -598,15 +600,6 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (!input.msg_version)
 		return -EINVAL;
 
-	mutex_lock(&snp_cmd_mutex);
-
-	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
-		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		mutex_unlock(&snp_cmd_mutex);
-		return -ENOTTY;
-	}
-
 	switch (ioctl) {
 	case SNP_GET_REPORT:
 		ret = get_report(snp_dev, &input);
@@ -628,8 +621,6 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 		break;
 	}
 
-	mutex_unlock(&snp_cmd_mutex);
-
 	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
@@ -744,8 +735,6 @@ static int sev_svsm_report_new(struct tsm_report *report, void *data)
 	man_len = SZ_4K;
 	certs_len = SEV_FW_BLOB_MAX_SIZE;
 
-	guard(mutex)(&snp_cmd_mutex);
-
 	if (guid_is_null(&desc->service_guid)) {
 		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
 	} else {
@@ -880,14 +869,6 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	if (!buf)
 		return -ENOMEM;
 
-	guard(mutex)(&snp_cmd_mutex);
-
-	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
-		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		return -ENOTTY;
-	}
-
 	cert_table = buf + report_size;
 	struct snp_ext_report_req ext_req = {
 		.data = { .vmpl = desc->privlevel },

