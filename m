Return-Path: <linux-tip-commits+bounces-4891-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5BA8593A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE73F1890A6B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD3221289;
	Fri, 11 Apr 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uX7vGStJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7z1aeg2M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09087204840;
	Fri, 11 Apr 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366547; cv=none; b=OEZ5ise+mb5/JooO5vY8t1/p4Ors6o9eDQCFWu/gcIAVS548dYBbqTfOmq5oI268XsYFPGJ4cJx2yw3IrI5e5KMYMKxKrpa3XLmUhrGkmuHU/A8Dh3JuHic51ShKBtriPR0r94Re3YNfBfyQGeyxvk23thu11D5OE7A79py4Kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366547; c=relaxed/simple;
	bh=L00IjLlZ2rWkQaW1//YsBvypWiWceXUt03CVZefdY9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ed83YZHQSkCS3mdfI9RvLgnFEnYK51qeOFhGv7xBqARlKJ37Y6LNJFLWepxOao3xGeo+fb4FQXFxun2X77DTAx9iTAKp8NeJK06A56YKNKtURXRUu9Vi5F74ngsY2kDNJaMLAAMRWgZfkHAEoyWi3e6Yf4+AvftfX2eAUGu9/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uX7vGStJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7z1aeg2M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744366544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4GniOxpV0OBM6kwuRup1fM/XRNRpCGpV3hqZTqy/Ow=;
	b=uX7vGStJZqRF4YVMbyFFf7RC3pB71UAovUxuorDPhoSuhck5a4xeDGj5SoXx+LDIBMUbci
	rQlVfWmzD9fujaMSm1fnrpDGNjd4DDZfH720uGU9m9MquzHNRW9NWtNg9r6w1eVnxn3rDt
	o0K6S/4WeNteUkekEeAGeW7x1Fy5KeBl45+O3yhsIGMBzPUgTdN2ImxD3O0/Mugi9NWEOl
	qGHm6e0qnURGBNOlchDyNjLpPK3O4MtXPP721ODUSBgOoCFMgYtw6/8xwUse2Vis+hxBx5
	6nNG7HV611fm0iwabn5LiCb8RKDr17rxFd2u7xVQyZ9DEN3+9gAWe1Et+X8B2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744366544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4GniOxpV0OBM6kwuRup1fM/XRNRpCGpV3hqZTqy/Ow=;
	b=7z1aeg2MJMyhFf7fbqBfVhHllum54U3c4Twen1J+NnLc5nucT0epnBBYEzyoOXNlWfHEkJ
	KKnLxli6BPKa0uDw==
From: "tip-bot2 for Stefano Garzarella" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add SVSM vTPM probe/send_command functions
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403100943.120738-2-sgarzare@redhat.com>
References: <20250403100943.120738-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436654323.31282.652380775473462628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     770de678bc281f6b0be339c29c1ad74dfb0e9325
Gitweb:        https://git.kernel.org/tip/770de678bc281f6b0be339c29c1ad74dfb0=
e9325
Author:        Stefano Garzarella <sgarzare@redhat.com>
AuthorDate:    Thu, 03 Apr 2025 12:09:39 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Apr 2025 16:15:41 +02:00

x86/sev: Add SVSM vTPM probe/send_command functions

Add two new functions to probe and send commands to the SVSM vTPM. They
leverage the two calls defined by the AMD SVSM specification [1] for the vTPM
protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.

Expose snp_svsm_vtpm_send_command() to be used by a TPM driver.

  [1] "Secure VM Service Module for SEV-SNP Guests"
      Publication # 58019 Revision: 1.00

  [ bp: Some doc touchups. ]

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20250403100943.120738-2-sgarzare@redhat.com
---
 arch/x86/coco/sev/core.c   | 58 +++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/sev.h |  7 ++++-
 2 files changed, 65 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b0c1a7a..ecd09da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2625,6 +2625,64 @@ e_restore_irq:
 	return ret;
 }
=20
+/**
+ * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
+ *
+ * Check that there is SVSM and that it supports at least TPM_SEND_COMMAND
+ * which is the only request used so far.
+ *
+ * Return: true if the platform provides a vTPM SVSM device, false otherwise.
+ */
+static bool snp_svsm_vtpm_probe(void)
+{
+	struct svsm_call call =3D {};
+
+	/* The vTPM device is available only if a SVSM is present */
+	if (!snp_vmpl)
+		return false;
+
+	call.caa =3D svsm_get_caa();
+	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
+
+	if (svsm_perform_call_protocol(&call))
+		return false;
+
+	/* Check platform commands contains TPM_SEND_COMMAND - platform command 8 */
+	return call.rcx_out & BIT_ULL(8);
+}
+
+/**
+ * snp_svsm_vtpm_send_command() - Execute a vTPM operation on SVSM
+ * @buffer: A buffer used to both send the command and receive the response.
+ *
+ * Execute a SVSM_VTPM_CMD call as defined by
+ * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 Revisio=
n: 1.00
+ *
+ * All command request/response buffers have a common structure as specified=
 by
+ * the following table:
+ *     Byte      Size   =C2=A0=C2=A0 =C2=A0In/Out=C2=A0=C2=A0=C2=A0=C2=A0Des=
cription
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0In=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Platform command
+=C2=A0*=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command response size
+ *
+ * Each command can build upon this common request/response structure to cre=
ate
+ * a structure specific to the command. See include/linux/tpm_svsm.h for more
+ * details.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int snp_svsm_vtpm_send_command(u8 *buffer)
+{
+	struct svsm_call call =3D {};
+
+	call.caa =3D svsm_get_caa();
+	call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
+	call.rcx =3D __pa(buffer);
+
+	return svsm_perform_call_protocol(&call);
+}
+EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
+
 static struct platform_device sev_guest_device =3D {
 	.name		=3D "sev-guest",
 	.id		=3D -1,
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ba7999f..d9ba035 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -384,6 +384,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
=20
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
=20
 extern u8 snp_vmpl;
@@ -481,6 +485,8 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
 int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req =
*req,
 			   struct snp_guest_request_ioctl *rio);
=20
+int snp_svsm_vtpm_send_command(u8 *buffer);
+
 void __init snp_secure_tsc_prepare(void);
 void __init snp_secure_tsc_init(void);
=20
@@ -524,6 +530,7 @@ static inline struct snp_msg_desc *snp_msg_alloc(void) { =
return NULL; }
 static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
 static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, struct =
snp_guest_req *req,
 					 struct snp_guest_request_ioctl *rio) { return -ENODEV; }
+static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
=20

