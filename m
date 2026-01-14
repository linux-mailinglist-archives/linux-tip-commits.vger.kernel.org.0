Return-Path: <linux-tip-commits+bounces-7973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C967DD1BD79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006A13041CC6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C146224244;
	Wed, 14 Jan 2026 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6h4+pjQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALE4SoDm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C422756A;
	Wed, 14 Jan 2026 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351498; cv=none; b=XNWsCKmIlCSbOQHrsbpKv+Krp9AwWy+TUwSg6KgfLN9VzNIFhHTNC3ojNwrQeCdrAKK1vh/Ei2XdkBiLs0rutjoAB2w98blC/Q9YqWk0bfprgAGSo5RsYzRJT6vGftI/EKKIvF/8FEMaI0+pk0q4SLDYeDkLz39Q4kh948H8jwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351498; c=relaxed/simple;
	bh=qpPR+nVpQGzZ9EvJUhUXl4W5f7V1mp7HyzQHMXZGb4U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IurYgtr3ao/cklycbZitWdQv5p1eGjFlZsUTLdqjbVGjZYsA6dKRejXeNAshg5AkUbkoar6b3x75e9+U95gh2D9IsAlXrbek3xNP4CiKIjiMDn5+jIqfOWHvjLR6wDVslJp06oQYjyAifznYN4wOBTjdjLtQN4RCMQaLlQS2GEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6h4+pjQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALE4SoDm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50uIL5+GJvmvBlrqQF0C0yPX/cPGARawie+HjyCYOT8=;
	b=L6h4+pjQg6fDs689fAPDM3AYdIgXNeIUFWrPse1SveAC+CU3C1afLF5A6KtM/pMDPmIguJ
	67+uqvEZ7XbQZZGyzIJefMe6dyI0BYOiqCV+hEEMepGHFWWi+FQQXi79id/pHy8NEDbfX+
	ykPIZOqCjY1Ida7bjUjVMn5X4Ri+tB8FVkkBmaqkUgWa1YALGCOVzL6IInEH9eD/iloHtI
	iiUJBOAe69v7Uu7oPBFA/KfIdYFbv+zJ6aL1DYl7GeuqxwNUqoIpt/xmpwdM6JbXpG0bmN
	oEkWGX45SljOo2IXfH4K4eebWLgnHudoGYWWFrrXnP5U3wz24Fplq8E8fRI5Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50uIL5+GJvmvBlrqQF0C0yPX/cPGARawie+HjyCYOT8=;
	b=ALE4SoDm0KJytdV2kMiNPhgqVeAjkUVlnThX1Zc2PlUPQ38LueTvi7XS+yXfp7BT7Er8iV
	dH4H/qstx6RjNZBg==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/entry/vdso: Include GNU_PROPERTY and GNU_STACK PHDRs
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-8-hpa@zytor.com>
References: <20251216212606.1325678-8-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835149226.510.9851010274012055542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     8717b02b8c030dc0c4b55781b59e88def0a1a92f
Gitweb:        https://git.kernel.org/tip/8717b02b8c030dc0c4b55781b59e88def0a=
1a92f
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:26:01 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/entry/vdso: Include GNU_PROPERTY and GNU_STACK PHDRs

Currently the vdso doesn't include .note.gnu.property or a GNU noexec
stack annotation (the -z noexecstack in the linker script is
ineffective because we specify PHDRs explicitly.)

The motivation is that the dynamic linker currently do not check
these.

However, this is a weak excuse: the vdso*.so are also supposed to be
usable at link libraries, and there is no reason why the dynamic
linker might not want or need to check these in the future, so add
them back in -- it is trivial enough.

Use symbolic constants for the PHDR permission flags.

[ v4: drop unrelated formatting changes ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-8-hpa@zytor.com
---
 arch/x86/entry/vdso/common/vdso-layout.lds.S | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vd=
so/common/vdso-layout.lds.S
index ec1ac19..a1e30be 100644
--- a/arch/x86/entry/vdso/common/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -47,18 +47,18 @@ SECTIONS
 		*(.gnu.linkonce.b.*)
 	}						:text
=20
-	/*
-	 * Discard .note.gnu.property sections which are unused and have
-	 * different alignment requirement from vDSO note sections.
-	 */
-	/DISCARD/ : {
+	.note.gnu.property : {
 		*(.note.gnu.property)
-	}
-	.note		: { *(.note.*) }		:text	:note
-
-	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+	}					:text :note :gnu_property
+	.note		: {
+		*(.note*)
+	}					:text :note
=20
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+	.eh_frame	: {
+		KEEP (*(.eh_frame))
+		*(.eh_frame.*)
+	}					:text
=20
 	/*
 	 * Text is well-separated from actual data: there's plenty of
@@ -87,15 +87,23 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constan=
t.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_STACK	0x6474e551
+#define PT_GNU_PROPERTY	0x6474e553
=20
 /*
  * We must supply the ELF program headers explicitly to get just one
  * PT_LOAD segment, and set the flags explicitly to make segments read-only.
- */
+*/
+#define PF_R	FLAGS(4)
+#define PF_RW	FLAGS(6)
+#define PF_RX	FLAGS(5)
+
 PHDRS
 {
-	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
-	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
-	note		PT_NOTE		FLAGS(4);		/* PF_R */
-	eh_frame_hdr	PT_GNU_EH_FRAME;
+	text		PT_LOAD		PF_RX FILEHDR PHDRS;
+	dynamic		PT_DYNAMIC	PF_R;
+	note		PT_NOTE		PF_R;
+	eh_frame_hdr	PT_GNU_EH_FRAME PF_R;
+	gnu_stack	PT_GNU_STACK	PF_RW;
+	gnu_property	PT_GNU_PROPERTY	PF_R;
 }

