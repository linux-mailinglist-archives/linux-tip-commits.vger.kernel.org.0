Return-Path: <linux-tip-commits+bounces-7105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63486C22372
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 21:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A78FC350347
	for <lists+linux-tip-commits@lfdr.de>; Thu, 30 Oct 2025 20:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2E2E0B44;
	Thu, 30 Oct 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBAjsnlz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZF1dv0h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BED34D39B;
	Thu, 30 Oct 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855717; cv=none; b=AIbDaKKPKlFmBIbur/w1tLICvIiaonhRXCbpI+qic/P4JMLIx3Yar3tO7iRdebKv3KhySLTY2egG+yAcGuqkhrc1gDTrlRQsJUQthmwZEkPTuXhROoAI7ECky8Jk/kH+msHzVloVaM8licJhm4ronojYSHUQUXAGD5PcYocni+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855717; c=relaxed/simple;
	bh=u6hx9SEhRgjfnBnx5lWJ5ahMm9W5rgYKkgVq2dkVHh0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VDyFz73bwOjLdhBehtjmIlz+IvymOn+3AI7W7ZWsZ5CAXe+Q1iQ3lI2s4zcVir4YRj76U6Kli6j9r7zBAzkOUqS3jqifvKrLHZFYNS7t00JPCMTeuDcZ2uvZQyC+/Wdb8syRQKwL1IAOtdQfITNBwRCDEgCM+nmrsGOnukD8EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBAjsnlz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZF1dv0h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 30 Oct 2025 20:21:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761855713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEGOREd6t+KZF8iwKAsmgjRBl2FuRkSt1ePvp7NS1Dk=;
	b=pBAjsnlz1qNuBost/3ONFMFGY8r/KKLm1zwWA8mbTzm8v8mcCmG5a2tFsVZTMl9zdYw05u
	LHwxln+HEMKvHrG5X98T0mrjq/qvJ+zJVTU6NLY46yX2E4aCFaNzGRfHMlypw1zx3p17eE
	RUV5NSkorZMGhNyUc95B/ahnRCWMa3nxm9DZLy9vw6FOlibK8TPCYYZMylxIO24O94cPPc
	Rc2KSau9tCseCqEHl0tIm0cgKyMLAKZRLHys15s8yCkX/C4SqRRz2x0/vlbpqPBml+NND9
	aKyv6IafbLXrtSNyuTl4GMoG11gGJcK6vXL3nnd7YLzEkQ2Sw0h3aMErLA2GDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761855713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEGOREd6t+KZF8iwKAsmgjRBl2FuRkSt1ePvp7NS1Dk=;
	b=nZF1dv0hR4vn8rGkc3s1dYgikzprRbimGXXsMoe3Tm0l5dJElWRHsgpxCWhOyBP6T6oYft
	OfU6M3iMUCD9nABA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode/AMD: Select which microcode patch to load
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251027133818.4363-1-bp@kernel.org>
References: <20251027133818.4363-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176185571196.2601451.2985321261068041190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     8d171045069c804e5ffaa18be590c42c6af0cf3f
Gitweb:        https://git.kernel.org/tip/8d171045069c804e5ffaa18be590c42c6af=
0cf3f
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 25 Sep 2025 13:46:00 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 30 Oct 2025 14:29:54 +01:00

x86/microcode/AMD: Select which microcode patch to load

All microcode patches up to the proper BIOS Entrysign fix are loaded
only after the sha256 signature carried in the driver has been verified.

Microcode patches after the Entrysign fix has been applied, do not need
that signature verification anymore.

In order to not abandon machines which haven't received the BIOS update
yet, add the capability to select which microcode patch to load.

The corresponding microcode container supplied through firmware-linux
has been modified to carry two patches per CPU type
(family/model/stepping) so that the proper one gets selected.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251027133818.4363-1-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 107 +++++++++++++++++----------
 1 file changed, 69 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 28ed8c0..8d3d111 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -186,47 +186,58 @@ static u32 cpuid_to_ucode_rev(unsigned int val)
 	return p.ucode_rev;
 }
=20
+static u32 get_cutoff_revision(u32 rev)
+{
+	switch (rev >> 8) {
+	case 0x80012: return 0x8001277; break;
+	case 0x80082: return 0x800820f; break;
+	case 0x83010: return 0x830107c; break;
+	case 0x86001: return 0x860010e; break;
+	case 0x86081: return 0x8608108; break;
+	case 0x87010: return 0x8701034; break;
+	case 0x8a000: return 0x8a0000a; break;
+	case 0xa0010: return 0xa00107a; break;
+	case 0xa0011: return 0xa0011da; break;
+	case 0xa0012: return 0xa001243; break;
+	case 0xa0082: return 0xa00820e; break;
+	case 0xa1011: return 0xa101153; break;
+	case 0xa1012: return 0xa10124e; break;
+	case 0xa1081: return 0xa108109; break;
+	case 0xa2010: return 0xa20102f; break;
+	case 0xa2012: return 0xa201212; break;
+	case 0xa4041: return 0xa404109; break;
+	case 0xa5000: return 0xa500013; break;
+	case 0xa6012: return 0xa60120a; break;
+	case 0xa7041: return 0xa704109; break;
+	case 0xa7052: return 0xa705208; break;
+	case 0xa7080: return 0xa708009; break;
+	case 0xa70c0: return 0xa70C009; break;
+	case 0xaa001: return 0xaa00116; break;
+	case 0xaa002: return 0xaa00218; break;
+	case 0xb0021: return 0xb002146; break;
+	case 0xb1010: return 0xb101046; break;
+	case 0xb2040: return 0xb204031; break;
+	case 0xb4040: return 0xb404031; break;
+	case 0xb6000: return 0xb600031; break;
+	case 0xb7000: return 0xb700031; break;
+	default: break;
+
+	}
+	return 0;
+}
+
 static bool need_sha_check(u32 cur_rev)
 {
+	u32 cutoff;
+
 	if (!cur_rev) {
 		cur_rev =3D cpuid_to_ucode_rev(bsp_cpuid_1_eax);
 		pr_info_once("No current revision, generating the lowest one: 0x%x\n", cur=
_rev);
 	}
=20
-	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <=3D 0x8001277; break;
-	case 0x80082: return cur_rev <=3D 0x800820f; break;
-	case 0x83010: return cur_rev <=3D 0x830107c; break;
-	case 0x86001: return cur_rev <=3D 0x860010e; break;
-	case 0x86081: return cur_rev <=3D 0x8608108; break;
-	case 0x87010: return cur_rev <=3D 0x8701034; break;
-	case 0x8a000: return cur_rev <=3D 0x8a0000a; break;
-	case 0xa0010: return cur_rev <=3D 0xa00107a; break;
-	case 0xa0011: return cur_rev <=3D 0xa0011da; break;
-	case 0xa0012: return cur_rev <=3D 0xa001243; break;
-	case 0xa0082: return cur_rev <=3D 0xa00820e; break;
-	case 0xa1011: return cur_rev <=3D 0xa101153; break;
-	case 0xa1012: return cur_rev <=3D 0xa10124e; break;
-	case 0xa1081: return cur_rev <=3D 0xa108109; break;
-	case 0xa2010: return cur_rev <=3D 0xa20102f; break;
-	case 0xa2012: return cur_rev <=3D 0xa201212; break;
-	case 0xa4041: return cur_rev <=3D 0xa404109; break;
-	case 0xa5000: return cur_rev <=3D 0xa500013; break;
-	case 0xa6012: return cur_rev <=3D 0xa60120a; break;
-	case 0xa7041: return cur_rev <=3D 0xa704109; break;
-	case 0xa7052: return cur_rev <=3D 0xa705208; break;
-	case 0xa7080: return cur_rev <=3D 0xa708009; break;
-	case 0xa70c0: return cur_rev <=3D 0xa70C009; break;
-	case 0xaa001: return cur_rev <=3D 0xaa00116; break;
-	case 0xaa002: return cur_rev <=3D 0xaa00218; break;
-	case 0xb0021: return cur_rev <=3D 0xb002146; break;
-	case 0xb1010: return cur_rev <=3D 0xb101046; break;
-	case 0xb2040: return cur_rev <=3D 0xb204031; break;
-	case 0xb4040: return cur_rev <=3D 0xb404031; break;
-	case 0xb6000: return cur_rev <=3D 0xb600031; break;
-	case 0xb7000: return cur_rev <=3D 0xb700031; break;
-	default: break;
-	}
+	cutoff =3D get_cutoff_revision(cur_rev);
+	if (cutoff)
+		return cur_rev <=3D cutoff;
=20
 	pr_info("You should not be seeing this. Please send the following couple of=
 lines to x86-<at>-kernel.org\n");
 	pr_info("CPUID(1).EAX: 0x%x, current revision: 0x%x\n", bsp_cpuid_1_eax, cu=
r_rev);
@@ -473,6 +484,7 @@ static int verify_patch(const u8 *buf, size_t buf_size, u=
32 *patch_size)
 {
 	u8 family =3D x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
+	u32 cur_rev, cutoff, patch_rev;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
@@ -512,11 +524,32 @@ static int verify_patch(const u8 *buf, size_t buf_size,=
 u32 *patch_size)
 	proc_id	=3D mc_hdr->processor_rev_id;
 	patch_fam =3D 0xf + (proc_id >> 12);
=20
-	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
-
 	if (patch_fam !=3D family)
 		return 1;
=20
+	cur_rev =3D get_patch_level();
+
+	/* No cutoff revision means old/unaffected by signing algorithm weakness =
=3D> matches */
+	cutoff =3D get_cutoff_revision(cur_rev);
+	if (!cutoff)
+		goto ok;
+
+	patch_rev =3D mc_hdr->patch_id;
+
+	ucode_dbg("cur_rev: 0x%x, cutoff: 0x%x, patch_rev: 0x%x\n",
+		  cur_rev, cutoff, patch_rev);
+
+	if (cur_rev <=3D cutoff && patch_rev <=3D cutoff)
+		goto ok;
+
+	if (cur_rev > cutoff && patch_rev > cutoff)
+		goto ok;
+
+	return 1;
+
+ok:
+	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
+
 	return 0;
 }
=20
@@ -585,8 +618,6 @@ static size_t parse_container(u8 *ucode, size_t size, str=
uct cont_desc *desc)
=20
 		mc =3D (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
=20
-		ucode_dbg("patch_id: 0x%x\n", mc->hdr.patch_id);
-
 		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize =3D patch_size;
 			desc->mc =3D mc;

