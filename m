Return-Path: <linux-tip-commits+bounces-7968-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6CD1BC55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F9A302B74C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7A86348;
	Wed, 14 Jan 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwNmsZXf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RS0dX/Rz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA063D994;
	Wed, 14 Jan 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348893; cv=none; b=PuR+fLtfkReVPv99K2JGYpaal/iq1h+3j30KGd0fI+/LoPvYdiBQPbUMSQuGCFA5c/I2QUNaAmgAb8o5mqkgNdQr2bDxuEEymVglvTg8YE/I21E3cM6P1Kcne3SPdEASV3cR/jizuDN3iHUleaFZGWOE4BN0K1TsuiBXmzGqxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348893; c=relaxed/simple;
	bh=q+ZYNNTurVxsCQMhVyt7aGFUSv9dOtqClV2Qb5SRk5U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XeidvNkQ0R5W71viQ0qlKfso5X/mUwyfn/M0+i9yht+qqCSFwr7Fb/3JvaRknwm5OlcnAp8HBx/WaoG7CvpvID0cjulVe/Oho5bz3ZMq6WjjUzX9dC/0Gdilvn279BKQA0D3tI1zoGb6l1e4t9m/pzPnxZRWDCP692TJz3WiQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwNmsZXf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RS0dX/Rz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768348889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXPQSA6oLEkC8Oup7axjkcFdtJ6WtHqitD0GmBKiQyI=;
	b=YwNmsZXfbbSgyonNt5kmVOmfiTjCR3lxDOUg+Xz3mKQIm4YbvQC5OF3Td7LZ2b45QQVs+g
	xR11Ntaju9hWyYo9P4sT9RCblEiWJQAkO2NwIuATlOtxvGvZNLTBbrFNmCESOLHUIt0mQk
	wN7wgCq9b/h5p+oPYwM1CccUdtQY8z44jgX8gDazg3F3/8znRL595r/FZkl4ZTkZCPvSec
	IWoz9NbmABtF1hMPV/iXYvMgYgApxiBTYoMUrmZh5jo6aneHK3KOlEsTi3O/oYdvxGV8Tf
	jOW+e2mmWgOUIaoOs6zsej2mgXJUrBvMOeomCt8RxgUUbvQEdrPKjXTVfhdh6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768348889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXPQSA6oLEkC8Oup7axjkcFdtJ6WtHqitD0GmBKiQyI=;
	b=RS0dX/Rzcvt9DlmNLTTN2Jx0RMFBqwvP31/gHPHGadPpA3DGuGqyeCdosNoDiiusz2ODfu
	ZXzNGG32uEhnTPDQ==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Rename vdso_image_* to vdso*_image
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-2-hpa@zytor.com>
References: <20251216212606.1325678-2-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176834888675.510.9602796359223321999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     93d73005bff4f600696ce30e366e742c3373b13d
Gitweb:        https://git.kernel.org/tip/93d73005bff4f600696ce30e366e742c337=
3b13d
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:25:55 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 15:33:20 -08:00

x86/entry/vdso: Rename vdso_image_* to vdso*_image

The vdso .so files are named vdso*.so. These structures are binary
images and descriptions of these files, so it is more consistent for
them to have a naming that more directly mirrors the filenames.

It is also very slightly more compact (by one character...) and
simplifies the Makefile just a little bit.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-2-hpa@zytor.com
---
 arch/x86/entry/syscall_32.c    |  2 +-
 arch/x86/entry/vdso/.gitignore | 11 ++++-------
 arch/x86/entry/vdso/Makefile   |  8 ++++----
 arch/x86/entry/vdso/vma.c      | 10 +++++-----
 arch/x86/include/asm/elf.h     |  2 +-
 arch/x86/include/asm/vdso.h    |  6 +++---
 arch/x86/kernel/process_64.c   |  6 +++---
 arch/x86/kernel/signal_32.c    |  4 ++--
 8 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index a67a644..8e82957 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -319,7 +319,7 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs =
*regs)
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
 	unsigned long landing_pad =3D (unsigned long)current->mm->context.vdso +
-					vdso_image_32.sym_int80_landing_pad;
+					vdso32_image.sym_int80_landing_pad;
=20
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
diff --git a/arch/x86/entry/vdso/.gitignore b/arch/x86/entry/vdso/.gitignore
index 37a6129..eb60859 100644
--- a/arch/x86/entry/vdso/.gitignore
+++ b/arch/x86/entry/vdso/.gitignore
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-vdso.lds
-vdsox32.lds
-vdso32-syscall-syms.lds
-vdso32-sysenter-syms.lds
-vdso32-int80-syms.lds
-vdso-image-*.c
-vdso2c
+*.lds
+*.so
+*.so.dbg
+vdso*-image.c
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index f247f5f..7f83302 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -16,9 +16,9 @@ vobjs-$(CONFIG_X86_SGX)	+=3D vsgx.o
 obj-y						+=3D vma.o extable.o
=20
 # vDSO images to build:
-obj-$(CONFIG_X86_64)				+=3D vdso-image-64.o
-obj-$(CONFIG_X86_X32_ABI)			+=3D vdso-image-x32.o
-obj-$(CONFIG_COMPAT_32)				+=3D vdso-image-32.o vdso32-setup.o
+obj-$(CONFIG_X86_64)				+=3D vdso64-image.o
+obj-$(CONFIG_X86_X32_ABI)			+=3D vdsox32-image.o
+obj-$(CONFIG_COMPAT_32)				+=3D vdso32-image.o vdso32-setup.o
=20
 vobjs :=3D $(addprefix $(obj)/, $(vobjs-y))
 vobjs32 :=3D $(addprefix $(obj)/, $(vobjs32-y))
@@ -44,7 +44,7 @@ hostprogs +=3D vdso2c
 quiet_cmd_vdso2c =3D VDSO2C  $@
       cmd_vdso2c =3D $(obj)/vdso2c $< $(<:%.dbg=3D%) $@
=20
-$(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FOR=
CE
+$(obj)/vdso%-image.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
=20
 #
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index afe105b..8f98c2d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -65,7 +65,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mappin=
g *sm,
 static void vdso_fix_landing(const struct vdso_image *image,
 		struct vm_area_struct *new_vma)
 {
-	if (in_ia32_syscall() && image =3D=3D &vdso_image_32) {
+	if (in_ia32_syscall() && image =3D=3D &vdso32_image) {
 		struct pt_regs *regs =3D current_pt_regs();
 		unsigned long vdso_land =3D image->sym_int80_landing_pad;
 		unsigned long old_land_addr =3D vdso_land +
@@ -230,7 +230,7 @@ static int load_vdso32(void)
 	if (vdso32_enabled !=3D 1)  /* Other values all mean "disabled" */
 		return 0;
=20
-	return map_vdso(&vdso_image_32, 0);
+	return map_vdso(&vdso32_image, 0);
 }
=20
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
@@ -239,7 +239,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm=
, int uses_interp)
 		if (!vdso64_enabled)
 			return 0;
=20
-		return map_vdso(&vdso_image_64, 0);
+		return map_vdso(&vdso64_image, 0);
 	}
=20
 	return load_vdso32();
@@ -252,7 +252,7 @@ int compat_arch_setup_additional_pages(struct linux_binpr=
m *bprm,
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && x32) {
 		if (!vdso64_enabled)
 			return 0;
-		return map_vdso(&vdso_image_x32, 0);
+		return map_vdso(&vdsox32_image, 0);
 	}
=20
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
@@ -267,7 +267,7 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	const struct vdso_image *image =3D current->mm->context.vdso_image;
 	unsigned long vdso =3D (unsigned long) current->mm->context.vdso;
=20
-	if (in_ia32_syscall() && image =3D=3D &vdso_image_32) {
+	if (in_ia32_syscall() && image =3D=3D &vdso32_image) {
 		if (regs->ip =3D=3D vdso + image->sym_vdso32_sigreturn_landing_pad ||
 		    regs->ip =3D=3D vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
 			return true;
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 6c8fdc9..2ba5f16 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -361,7 +361,7 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
=20
 #define VDSO_ENTRY							\
 	((unsigned long)current->mm->context.vdso +			\
-	 vdso_image_32.sym___kernel_vsyscall)
+	 vdso32_image.sym___kernel_vsyscall)
=20
 struct linux_binprm;
=20
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index b7253ef..e8afbe9 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -27,9 +27,9 @@ struct vdso_image {
 	long sym_vdso32_rt_sigreturn_landing_pad;
 };
=20
-extern const struct vdso_image vdso_image_64;
-extern const struct vdso_image vdso_image_x32;
-extern const struct vdso_image vdso_image_32;
+extern const struct vdso_image vdso64_image;
+extern const struct vdso_image vdsox32_image;
+extern const struct vdso_image vdso32_image;
=20
 extern int __init init_vdso_image(const struct vdso_image *image);
=20
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 432c0a0..08e72f4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -941,14 +941,14 @@ long do_arch_prctl_64(struct task_struct *task, int opt=
ion, unsigned long arg2)
 #ifdef CONFIG_CHECKPOINT_RESTORE
 # ifdef CONFIG_X86_X32_ABI
 	case ARCH_MAP_VDSO_X32:
-		return prctl_map_vdso(&vdso_image_x32, arg2);
+		return prctl_map_vdso(&vdsox32_image, arg2);
 # endif
 # ifdef CONFIG_IA32_EMULATION
 	case ARCH_MAP_VDSO_32:
-		return prctl_map_vdso(&vdso_image_32, arg2);
+		return prctl_map_vdso(&vdso32_image, arg2);
 # endif
 	case ARCH_MAP_VDSO_64:
-		return prctl_map_vdso(&vdso_image_64, arg2);
+		return prctl_map_vdso(&vdso64_image, arg2);
 #endif
 #ifdef CONFIG_ADDRESS_MASKING
 	case ARCH_GET_UNTAG_MASK:
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 42bbc42..e55cf19 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -282,7 +282,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs=
 *regs)
 		/* Return stub is in 32bit vsyscall page */
 		if (current->mm->context.vdso)
 			restorer =3D current->mm->context.vdso +
-				vdso_image_32.sym___kernel_sigreturn;
+				vdso32_image.sym___kernel_sigreturn;
 		else
 			restorer =3D &frame->retcode;
 	}
@@ -368,7 +368,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_r=
egs *regs)
 		restorer =3D ksig->ka.sa.sa_restorer;
 	else
 		restorer =3D current->mm->context.vdso +
-			vdso_image_32.sym___kernel_rt_sigreturn;
+			vdso32_image.sym___kernel_rt_sigreturn;
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
=20
 	/*

