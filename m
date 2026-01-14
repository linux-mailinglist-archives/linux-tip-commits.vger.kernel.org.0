Return-Path: <linux-tip-commits+bounces-7967-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11FD1BC52
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F488301D661
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DF86348;
	Wed, 14 Jan 2026 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rKzuBhX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X0BVMKJ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FEAD2C;
	Wed, 14 Jan 2026 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348892; cv=none; b=FlX7AwAo60qAOB/YaTD+d9L6gSkR33xTVdApPd7/Xu+czkGMCIi2xZBFvk0J+shgQrWHdI4HfWSSaGjrYDb/B2a1Bd7df/FFbbd/+vYAZMv1rETPJSV+dpm6KoXXYiEFoTi8y1Fp2DCkBdvNQmnpiBoYCoa7IjvJb7W2Ep+S7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348892; c=relaxed/simple;
	bh=zGjQeB4MtTUvNQJwi+sGLa/A1G3yppY5y5HMTDFJP3Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gfJkLRA7FS7qHMy2HC92aeN5jIEm3n6zjTiXaBiQZi8FT60TXulmIH5a5QW2bv5hS++hBGXMonKK+H6G5ZxwgTbeVzc7ul3X3GvrFWVg+EiF7RsbqlX9kHzcc3DpIds/HHkDvhcvFWDAU1ZAhK4c2kdhytIyiG+wqohPQyBY0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rKzuBhX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X0BVMKJ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768348885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RrsdoXAIOZmi+ZP4B5XUyT7LzDGniBdALmnx3OqlI8=;
	b=0rKzuBhXxtWRkkCnsb1VJhoRE1Z0E/e4MJ2k/IEAvk3frj3JcGmKBGXu3pPViy+MDP0fv/
	uh22wo3wuV6998MKl1feK/2w2O4qs3QgMecAtf0kHh07x6ZuPcs3yhwnyKcTwMKLRpoLeY
	EAhudthRoaKYfXUrZFCXwtwZCjzVGeFjckbBF9Kp8Q2nGvPgd5rF6dXXYC4XMBmq7fYd70
	7kyMOmVG6vtPqQ3H+tpgqiVq6qwLKzeiMCYgDqECo5eV2t7pPjKLjjMOeboYqVT51in5UL
	tNijknmPHSETcLLi19kbHDefwoFiaDpLIuXAwCkVONKvpzIeg/eJSe46vgoOwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768348885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RrsdoXAIOZmi+ZP4B5XUyT7LzDGniBdALmnx3OqlI8=;
	b=X0BVMKJ3KlZwddlxaXHAjMt0JebPnxhYIbhhoYKrMMHydODR35rfp+JTL1995Poh0Jyg/v
	9UlCegq9slaZnjAg==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Refactor the vdso build
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-4-hpa@zytor.com>
References: <20251216212606.1325678-4-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176834888395.510.11100324851779042502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     693c819fedcdcabfda7488e2d5e355a84c2fd1b0
Gitweb:        https://git.kernel.org/tip/693c819fedcdcabfda7488e2d5e355a84c2=
fd1b0
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:25:57 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 15:35:09 -08:00

x86/entry/vdso: Refactor the vdso build

- Separate out the vdso sources into common, vdso32, and vdso64
  directories.
- Build the 32- and 64-bit vdsos in their respective subdirectories;
  this greatly simplifies the build flags handling.
- Unify the mangling of Makefile flags between the 32- and 64-bit
  vdso code as much as possible; all common rules are put in
  arch/x86/entry/vdso/common/Makefile.include. The remaining
  is very simple for 32 bits; the 64-bit one is only slightly more
  complicated because it contains the x32 generation rule.
- Define __DISABLE_EXPORTS when building the vdso. This need seems to
  have been masked by different ordering compile flags before.
- Change CONFIG_X86_64 to BUILD_VDSO32_64 in vdso32/system_call.S,
  to make it compatible with including fake_32bit_build.h.
- The -fcf-protection=3D option was "leaking" from the kernel build,
  for reasons that was not clear to me. Furthermore, several
  distributions ship with it set to a default value other than
  "-fcf-protection=3Dnone". Make it match the configuration options
  for *user space*.

Note that this patch may seem large, but the vast majority of it is
simply code movement.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-4-hpa@zytor.com
---
 arch/x86/entry/vdso/Makefile                   | 161 +--------------
 arch/x86/entry/vdso/common/Makefile.include    |  89 ++++++++-
 arch/x86/entry/vdso/common/note.S              |  18 ++-
 arch/x86/entry/vdso/common/vclock_gettime.c    |  77 +++++++-
 arch/x86/entry/vdso/common/vdso-layout.lds.S   | 101 +++++++++-
 arch/x86/entry/vdso/common/vgetcpu.c           |  22 ++-
 arch/x86/entry/vdso/vclock_gettime.c           |  77 +-------
 arch/x86/entry/vdso/vdso-layout.lds.S          | 101 +---------
 arch/x86/entry/vdso/vdso-note.S                |  15 +-
 arch/x86/entry/vdso/vdso.lds.S                 |  37 +---
 arch/x86/entry/vdso/vdso32/Makefile            |  24 ++-
 arch/x86/entry/vdso/vdso32/note.S              |  19 +--
 arch/x86/entry/vdso/vdso32/system_call.S       |   2 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c    |   5 +-
 arch/x86/entry/vdso/vdso32/vdso32.lds.S        |   2 +-
 arch/x86/entry/vdso/vdso32/vgetcpu.c           |   4 +-
 arch/x86/entry/vdso/vdso64/Makefile            |  46 ++++-
 arch/x86/entry/vdso/vdso64/note.S              |   1 +-
 arch/x86/entry/vdso/vdso64/vclock_gettime.c    |   1 +-
 arch/x86/entry/vdso/vdso64/vdso64.lds.S        |  37 +++-
 arch/x86/entry/vdso/vdso64/vdsox32.lds.S       |  27 ++-
 arch/x86/entry/vdso/vdso64/vgetcpu.c           |   1 +-
 arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S | 178 ++++++++++++++++-
 arch/x86/entry/vdso/vdso64/vgetrandom.c        |  15 +-
 arch/x86/entry/vdso/vdso64/vsgx.S              | 150 +++++++++++++-
 arch/x86/entry/vdso/vdsox32.lds.S              |  27 +--
 arch/x86/entry/vdso/vgetcpu.c                  |  22 +--
 arch/x86/entry/vdso/vgetrandom-chacha.S        | 178 +----------------
 arch/x86/entry/vdso/vgetrandom.c               |  15 +-
 arch/x86/entry/vdso/vsgx.S                     | 150 +-------------
 30 files changed, 798 insertions(+), 804 deletions(-)
 create mode 100644 arch/x86/entry/vdso/common/Makefile.include
 create mode 100644 arch/x86/entry/vdso/common/note.S
 create mode 100644 arch/x86/entry/vdso/common/vclock_gettime.c
 create mode 100644 arch/x86/entry/vdso/common/vdso-layout.lds.S
 create mode 100644 arch/x86/entry/vdso/common/vgetcpu.c
 delete mode 100644 arch/x86/entry/vdso/vclock_gettime.c
 delete mode 100644 arch/x86/entry/vdso/vdso-layout.lds.S
 delete mode 100644 arch/x86/entry/vdso/vdso-note.S
 delete mode 100644 arch/x86/entry/vdso/vdso.lds.S
 create mode 100644 arch/x86/entry/vdso/vdso32/Makefile
 create mode 100644 arch/x86/entry/vdso/vdso64/Makefile
 create mode 100644 arch/x86/entry/vdso/vdso64/note.S
 create mode 100644 arch/x86/entry/vdso/vdso64/vclock_gettime.c
 create mode 100644 arch/x86/entry/vdso/vdso64/vdso64.lds.S
 create mode 100644 arch/x86/entry/vdso/vdso64/vdsox32.lds.S
 create mode 100644 arch/x86/entry/vdso/vdso64/vgetcpu.c
 create mode 100644 arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vdso64/vgetrandom.c
 create mode 100644 arch/x86/entry/vdso/vdso64/vsgx.S
 delete mode 100644 arch/x86/entry/vdso/vdsox32.lds.S
 delete mode 100644 arch/x86/entry/vdso/vgetcpu.c
 delete mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 delete mode 100644 arch/x86/entry/vdso/vgetrandom.c
 delete mode 100644 arch/x86/entry/vdso/vsgx.S

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3d9b09f..987b43f 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,159 +3,10 @@
 # Building vDSO images for x86.
 #
=20
-# Include the generic Makefile to check the built vDSO:
-include $(srctree)/lib/vdso/Makefile.include
+# Regular kernel objects
+obj-y				:=3D vma.o extable.o
+obj-$(CONFIG_COMPAT_32)		+=3D vdso32-setup.o
=20
-# Files to link into the vDSO:
-vobjs-y :=3D vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o vgetrandom-=
chacha.o
-vobjs32-y :=3D vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
-vobjs32-y +=3D vdso32/vclock_gettime.o vdso32/vgetcpu.o
-vobjs-$(CONFIG_X86_SGX)	+=3D vsgx.o
-
-# Files to link into the kernel:
-obj-y						+=3D vma.o extable.o
-
-# vDSO images to build:
-obj-$(CONFIG_X86_64)				+=3D vdso64-image.o
-obj-$(CONFIG_X86_X32_ABI)			+=3D vdsox32-image.o
-obj-$(CONFIG_COMPAT_32)				+=3D vdso32-image.o vdso32-setup.o
-
-vobjs :=3D $(addprefix $(obj)/, $(vobjs-y))
-vobjs32 :=3D $(addprefix $(obj)/, $(vobjs32-y))
-
-$(obj)/vdso.o: $(obj)/vdso.so
-
-targets +=3D vdso.lds $(vobjs-y)
-targets +=3D vdso32/vdso32.lds $(vobjs32-y)
-
-targets +=3D $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).=
so.dbg)
-
-CPPFLAGS_vdso.lds +=3D -P -C
-
-VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vdso.so.1 \
-			-z max-page-size=3D4096
-
-$(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
-	$(call if_changed,vdso_and_check)
-
-VDSO2C =3D $(objtree)/arch/x86/tools/vdso2c
-
-quiet_cmd_vdso2c =3D VDSO2C  $@
-      cmd_vdso2c =3D $(VDSO2C) $< $(<:%.dbg=3D%) $@
-
-$(obj)/vdso%-image.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(VDSO2C) FORCE
-	$(call if_changed,vdso2c)
-
-#
-# Don't omit frame pointers for ease of userspace debugging, but do
-# optimize sibling calls.
-#
-CFL :=3D $(PROFILING) -mcmodel=3Dsmall -fPIC -O2 -fasynchronous-unwind-table=
s -m64 \
-       $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
-       -fno-omit-frame-pointer -foptimize-sibling-calls \
-       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
-
-ifdef CONFIG_MITIGATION_RETPOLINE
-ifneq ($(RETPOLINE_VDSO_CFLAGS),)
-  CFL +=3D $(RETPOLINE_VDSO_CFLAGS)
-endif
-endif
-
-$(vobjs): KBUILD_CFLAGS :=3D $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) =
$(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) $(GCC_PLUGINS_CFL=
AGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
-$(vobjs): KBUILD_AFLAGS +=3D -DBUILD_VDSO
-
-#
-# vDSO code runs in userspace and -pg doesn't help with profiling anyway.
-#
-CFLAGS_REMOVE_vclock_gettime.o =3D -pg
-CFLAGS_REMOVE_vdso32/vclock_gettime.o =3D -pg
-CFLAGS_REMOVE_vgetcpu.o =3D -pg
-CFLAGS_REMOVE_vdso32/vgetcpu.o =3D -pg
-CFLAGS_REMOVE_vsgx.o =3D -pg
-CFLAGS_REMOVE_vgetrandom.o =3D -pg
-
-#
-# X32 processes use x32 vDSO to access 64bit kernel data.
-#
-# Build x32 vDSO image:
-# 1. Compile x32 vDSO as 64bit.
-# 2. Convert object files to x32.
-# 3. Build x32 VDSO image with x32 objects, which contains 64bit codes
-# so that it can reach 64bit address space with 64bit pointers.
-#
-
-CPPFLAGS_vdsox32.lds =3D $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdsox32.lds =3D -m elf32_x86_64 -soname linux-vdso.so.1 \
-			   -z max-page-size=3D4096
-
-# x32-rebranded versions
-vobjx32s-y :=3D $(vobjs-y:.o=3D-x32.o)
-
-# same thing, but in the output directory
-vobjx32s :=3D $(addprefix $(obj)/, $(vobjx32s-y))
-
-# Convert 64bit object file to x32 for x32 vDSO.
-quiet_cmd_x32 =3D X32     $@
-      cmd_x32 =3D $(OBJCOPY) -O elf32-x86-64 $< $@
-
-$(obj)/%-x32.o: $(obj)/%.o FORCE
-	$(call if_changed,x32)
-
-targets +=3D vdsox32.lds $(vobjx32s-y)
-
-$(obj)/%.so: OBJCOPYFLAGS :=3D -S --remove-section __ex_table
-$(obj)/%.so: $(obj)/%.so.dbg FORCE
-	$(call if_changed,objcopy)
-
-$(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
-	$(call if_changed,vdso_and_check)
-
-CPPFLAGS_vdso32/vdso32.lds =3D $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds =3D -m elf_i386 -soname linux-gate.so.1
-
-KBUILD_AFLAGS_32 :=3D $(filter-out -m64,$(KBUILD_AFLAGS)) -DBUILD_VDSO
-$(obj)/vdso32.so.dbg: KBUILD_AFLAGS =3D $(KBUILD_AFLAGS_32)
-$(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) +=3D -m32
-
-KBUILD_CFLAGS_32 :=3D $(filter-out -m64,$(KBUILD_CFLAGS))
-KBUILD_CFLAGS_32 :=3D $(filter-out -mcmodel=3Dkernel,$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(KSTACK_ERASE_CFLAGS),$(KBUILD_CFLAGS_32=
))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 :=3D $(filter-out $(PADDING_CFLAGS),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 +=3D -m32 -msoft-float -mregparm=3D0 -fpic
-KBUILD_CFLAGS_32 +=3D -fno-stack-protector
-KBUILD_CFLAGS_32 +=3D $(call cc-option, -foptimize-sibling-calls)
-KBUILD_CFLAGS_32 +=3D -fno-omit-frame-pointer
-KBUILD_CFLAGS_32 +=3D -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS_32 +=3D -DBUILD_VDSO
-
-ifdef CONFIG_MITIGATION_RETPOLINE
-ifneq ($(RETPOLINE_VDSO_CFLAGS),)
-  KBUILD_CFLAGS_32 +=3D $(RETPOLINE_VDSO_CFLAGS)
-endif
-endif
-
-$(obj)/vdso32.so.dbg: KBUILD_CFLAGS =3D $(KBUILD_CFLAGS_32)
-
-$(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
-	$(call if_changed,vdso_and_check)
-
-#
-# The DSO images are built using a special linker script.
-#
-quiet_cmd_vdso =3D VDSO    $@
-      cmd_vdso =3D $(LD) -o $@ \
-		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^)
-
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 --no-undefine=
d \
-	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
-
-quiet_cmd_vdso_and_check =3D VDSO    $@
-      cmd_vdso_and_check =3D $(cmd_vdso); $(cmd_vdso_check)
+# vDSO directories
+obj-$(CONFIG_X86_64)		+=3D vdso64/
+obj-$(CONFIG_COMPAT_32)		+=3D vdso32/
diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vds=
o/common/Makefile.include
new file mode 100644
index 0000000..3514b4a
--- /dev/null
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Building vDSO images for x86.
+#
+
+# Include the generic Makefile to check the built vDSO:
+include $(srctree)/lib/vdso/Makefile.include
+
+obj-y    +=3D $(foreach x,$(vdsos-y),vdso$(x)-image.o)
+
+targets  +=3D $(foreach x,$(vdsos-y),vdso$(x)-image.c vdso$(x).so vdso$(x).s=
o.dbg vdso$(x).lds)
+targets  +=3D $(vobjs-y)
+
+# vobjs-y with $(obj)/ prepended
+vobjs :=3D $(addprefix $(obj)/,$(vobjs-y))
+
+# Options for vdso*.lds
+CPPFLAGS_VDSO_LDS :=3D -P -C -I$(src)/..
+$(obj)/%.lds : KBUILD_CPPFLAGS +=3D $(CPPFLAGS_VDSO_LDS)
+
+#
+# Options from KBUILD_[AC]FLAGS that should *NOT* be kept
+#
+flags-remove-y +=3D \
+	-D__KERNEL__ -mcmodel=3Dkernel -mregparm=3D3 \
+	-fno-pic -fno-PIC -fno-pie fno-PIE \
+	-mfentry -pg \
+	$(RANDSTRUCT_CFLAGS) $(GCC_PLUGIN_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
+	$(RETPOLINE_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+	$(PADDING_CFLAGS)
+
+#
+# Don't omit frame pointers for ease of userspace debugging, but do
+# optimize sibling calls.
+#
+flags-y +=3D -D__DISABLE_EXPORTS
+flags-y +=3D -DDISABLE_BRANCH_PROFILING
+flags-y +=3D -DBUILD_VDSO
+flags-y +=3D -I$(src)/.. -I$(srctree)
+flags-y +=3D -O2 -fpic
+flags-y +=3D -fno-stack-protector
+flags-y +=3D -fno-omit-frame-pointer
+flags-y +=3D -foptimize-sibling-calls
+flags-y +=3D -fasynchronous-unwind-tables
+
+# Reset cf protections enabled by compiler default
+flags-y +=3D $(call cc-option, -fcf-protection=3Dnone)
+flags-$(X86_USER_SHADOW_STACK) +=3D $(call cc-option, -fcf-protection=3Dretu=
rn)
+# When user space IBT is supported, enable this.
+# flags-$(CONFIG_USER_IBT) +=3D $(call cc-option, -fcf-protection=3Dbranch)
+
+flags-$(CONFIG_MITIGATION_RETPOLINE) +=3D $(RETPOLINE_VDSO_CFLAGS)
+
+# These need to be conditional on $(vobjs) as they do not apply to
+# the output vdso*-image.o files which are standard kernel objects.
+$(vobjs) : KBUILD_AFLAGS :=3D \
+	$(filter-out $(flags-remove-y),$(KBUILD_AFLAGS)) $(flags-y)
+$(vobjs) : KBUILD_CFLAGS :=3D \
+	$(filter-out $(flags-remove-y),$(KBUILD_CFLAGS)) $(flags-y)
+
+#
+# The VDSO images are built using a special linker script.
+#
+VDSO_LDFLAGS :=3D -shared --hash-style=3Dboth --build-id=3Dsha1 --no-undefin=
ed \
+	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
+
+quiet_cmd_vdso =3D VDSO    $@
+      cmd_vdso =3D $(LD) -o $@ \
+		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$*) \
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
+quiet_cmd_vdso_and_check =3D VDSO    $@
+      cmd_vdso_and_check =3D $(cmd_vdso); $(cmd_vdso_check)
+
+$(obj)/vdso%.so.dbg: $(obj)/vdso%.lds FORCE
+	$(call if_changed,vdso_and_check)
+
+$(obj)/%.so: OBJCOPYFLAGS :=3D -S --remove-section __ex_table
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+VDSO2C =3D $(objtree)/arch/x86/tools/vdso2c
+
+quiet_cmd_vdso2c =3D VDSO2C  $@
+      cmd_vdso2c =3D $(VDSO2C) $< $(<:%.dbg=3D%) $@
+
+$(obj)/%-image.c: $(obj)/%.so.dbg $(obj)/%.so $(VDSO2C) FORCE
+	$(call if_changed,vdso2c)
+
+$(obj)/%-image.o: $(obj)/%-image.c
diff --git a/arch/x86/entry/vdso/common/note.S b/arch/x86/entry/vdso/common/n=
ote.S
new file mode 100644
index 0000000..2cbd399
--- /dev/null
+++ b/arch/x86/entry/vdso/common/note.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO tex=
t.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/build-salt.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+
+/* Ideally this would use UTS_NAME, but using a quoted string here
+   doesn't work. Remember to change this when changing the
+   kernel's name. */
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/x86/entry/vdso/common/vclock_gettime.c b/arch/x86/entry/vds=
o/common/vclock_gettime.c
new file mode 100644
index 0000000..0debc19
--- /dev/null
+++ b/arch/x86/entry/vdso/common/vclock_gettime.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fast user context implementation of clock_gettime, gettimeofday, and time.
+ *
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ * Copyright 2019 ARM Limited
+ *
+ * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
+ *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
+ */
+#include <linux/time.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <vdso/gettime.h>
+
+#include "../../../../lib/vdso/gettimeofday.c"
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__attribute__((weak, alias("__vdso_gettimeofday")));
+
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
+{
+	return __cvdso_time(t);
+}
+
+__kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias(=
"__vdso_time")));
+
+
+#if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
+/* both 64-bit and x32 use these */
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
+
+int __vdso_clock_getres(clockid_t clock,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+
+#else
+/* i386 only */
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
+{
+	return __cvdso_clock_gettime32(clock, ts);
+}
+
+int clock_gettime(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_gettime")));
+
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
+
+int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+#endif
diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vd=
so/common/vdso-layout.lds.S
new file mode 100644
index 0000000..ec1ac19
--- /dev/null
+++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/vdso.h>
+#include <asm/vdso/vsyscall.h>
+#include <vdso/datapage.h>
+
+/*
+ * Linker script for vDSO.  This is an ELF shared object prelinked to
+ * its virtual address, and with only one read-only segment.
+ * This script controls its layout.
+ */
+
+SECTIONS
+{
+	/*
+	 * User/kernel shared data is before the vDSO.  This may be a little
+	 * uglier than putting it after the vDSO, but it avoids issues with
+	 * non-allocatable things that dangle past the end of the PT_LOAD
+	 * segment.
+	 */
+
+	VDSO_VVAR_SYMS
+
+	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vdso_u_data);
+	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
+	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
+
+	. =3D SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.rodata		: {
+		*(.rodata*)
+		*(.data*)
+		*(.sdata*)
+		*(.got.plt) *(.got)
+		*(.gnu.linkonce.d.*)
+		*(.bss*)
+		*(.dynbss*)
+		*(.gnu.linkonce.b.*)
+	}						:text
+
+	/*
+	 * Discard .note.gnu.property sections which are unused and have
+	 * different alignment requirement from vDSO note sections.
+	 */
+	/DISCARD/ : {
+		*(.note.gnu.property)
+	}
+	.note		: { *(.note.*) }		:text	:note
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+
+	/*
+	 * Text is well-separated from actual data: there's plenty of
+	 * stuff that isn't used at runtime in between.
+	 */
+
+	.text		: {
+		*(.text*)
+	}						:text	=3D0x90909090,
+
+
+
+	.altinstructions	: { *(.altinstructions) }	:text
+	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
+
+	__ex_table		: { *(__ex_table) }		:text
+
+	/DISCARD/ : {
+		*(.discard)
+		*(.discard.*)
+		*(__bug_table)
+	}
+}
+
+/*
+ * Very old versions of ld do not recognize this name token; use the constan=
t.
+ */
+#define PT_GNU_EH_FRAME	0x6474e550
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
diff --git a/arch/x86/entry/vdso/common/vgetcpu.c b/arch/x86/entry/vdso/commo=
n/vgetcpu.c
new file mode 100644
index 0000000..e464030
--- /dev/null
+++ b/arch/x86/entry/vdso/common/vgetcpu.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ *
+ * Fast user context implementation of getcpu()
+ */
+
+#include <linux/kernel.h>
+#include <linux/getcpu.h>
+#include <asm/segment.h>
+#include <vdso/processor.h>
+
+notrace long
+__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+{
+	vdso_read_cpunode(cpu, node);
+
+	return 0;
+}
+
+long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vcloc=
k_gettime.c
deleted file mode 100644
index 0debc19..0000000
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ /dev/null
@@ -1,77 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Fast user context implementation of clock_gettime, gettimeofday, and time.
- *
- * Copyright 2006 Andi Kleen, SUSE Labs.
- * Copyright 2019 ARM Limited
- *
- * 32 Bit compat layer by Stefani Seibold <stefani@seibold.net>
- *  sponsored by Rohde & Schwarz GmbH & Co. KG Munich/Germany
- */
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <vdso/gettime.h>
-
-#include "../../../../lib/vdso/gettimeofday.c"
-
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	return __cvdso_gettimeofday(tv, tz);
-}
-
-int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
-	__attribute__((weak, alias("__vdso_gettimeofday")));
-
-__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
-{
-	return __cvdso_time(t);
-}
-
-__kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias(=
"__vdso_time")));
-
-
-#if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
-/* both 64-bit and x32 use these */
-int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int clock_gettime(clockid_t, struct __kernel_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime")));
-
-int __vdso_clock_getres(clockid_t clock,
-			struct __kernel_timespec *res)
-{
-	return __cvdso_clock_getres(clock, res);
-}
-int clock_getres(clockid_t, struct __kernel_timespec *)
-	__attribute__((weak, alias("__vdso_clock_getres")));
-
-#else
-/* i386 only */
-int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
-{
-	return __cvdso_clock_gettime32(clock, ts);
-}
-
-int clock_gettime(clockid_t, struct old_timespec32 *)
-	__attribute__((weak, alias("__vdso_clock_gettime")));
-
-int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int clock_gettime64(clockid_t, struct __kernel_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime64")));
-
-int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res)
-{
-	return __cvdso_clock_getres_time32(clock, res);
-}
-
-int clock_getres(clockid_t, struct old_timespec32 *)
-	__attribute__((weak, alias("__vdso_clock_getres")));
-#endif
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
deleted file mode 100644
index ec1ac19..0000000
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ /dev/null
@@ -1,101 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/vdso.h>
-#include <asm/vdso/vsyscall.h>
-#include <vdso/datapage.h>
-
-/*
- * Linker script for vDSO.  This is an ELF shared object prelinked to
- * its virtual address, and with only one read-only segment.
- * This script controls its layout.
- */
-
-SECTIONS
-{
-	/*
-	 * User/kernel shared data is before the vDSO.  This may be a little
-	 * uglier than putting it after the vDSO, but it avoids issues with
-	 * non-allocatable things that dangle past the end of the PT_LOAD
-	 * segment.
-	 */
-
-	VDSO_VVAR_SYMS
-
-	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vdso_u_data);
-	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
-	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
-
-	. =3D SIZEOF_HEADERS;
-
-	.hash		: { *(.hash) }			:text
-	.gnu.hash	: { *(.gnu.hash) }
-	.dynsym		: { *(.dynsym) }
-	.dynstr		: { *(.dynstr) }
-	.gnu.version	: { *(.gnu.version) }
-	.gnu.version_d	: { *(.gnu.version_d) }
-	.gnu.version_r	: { *(.gnu.version_r) }
-
-	.dynamic	: { *(.dynamic) }		:text	:dynamic
-
-	.rodata		: {
-		*(.rodata*)
-		*(.data*)
-		*(.sdata*)
-		*(.got.plt) *(.got)
-		*(.gnu.linkonce.d.*)
-		*(.bss*)
-		*(.dynbss*)
-		*(.gnu.linkonce.b.*)
-	}						:text
-
-	/*
-	 * Discard .note.gnu.property sections which are unused and have
-	 * different alignment requirement from vDSO note sections.
-	 */
-	/DISCARD/ : {
-		*(.note.gnu.property)
-	}
-	.note		: { *(.note.*) }		:text	:note
-
-	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
-	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
-
-
-	/*
-	 * Text is well-separated from actual data: there's plenty of
-	 * stuff that isn't used at runtime in between.
-	 */
-
-	.text		: {
-		*(.text*)
-	}						:text	=3D0x90909090,
-
-
-
-	.altinstructions	: { *(.altinstructions) }	:text
-	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
-
-	__ex_table		: { *(__ex_table) }		:text
-
-	/DISCARD/ : {
-		*(.discard)
-		*(.discard.*)
-		*(__bug_table)
-	}
-}
-
-/*
- * Very old versions of ld do not recognize this name token; use the constan=
t.
- */
-#define PT_GNU_EH_FRAME	0x6474e550
-
-/*
- * We must supply the ELF program headers explicitly to get just one
- * PT_LOAD segment, and set the flags explicitly to make segments read-only.
- */
-PHDRS
-{
-	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
-	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
-	note		PT_NOTE		FLAGS(4);		/* PF_R */
-	eh_frame_hdr	PT_GNU_EH_FRAME;
-}
diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
deleted file mode 100644
index 7942317..0000000
--- a/arch/x86/entry/vdso/vdso-note.S
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * This supplies .note.* sections to go into the PT_NOTE inside the vDSO tex=
t.
- * Here we can supply some information useful to userland.
- */
-
-#include <linux/build-salt.h>
-#include <linux/uts.h>
-#include <linux/version.h>
-#include <linux/elfnote.h>
-
-ELFNOTE_START(Linux, 0, "a")
-	.long LINUX_VERSION_CODE
-ELFNOTE_END
-
-BUILD_SALT
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
deleted file mode 100644
index 0bab5f4..0000000
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Linker script for 64-bit vDSO.
- * We #include the file to define the layout details.
- *
- * This file defines the version script giving the user-exported symbols in
- * the DSO.
- */
-
-#define BUILD_VDSO64
-
-#include "vdso-layout.lds.S"
-
-/*
- * This controls what userland symbols we export from the vDSO.
- */
-VERSION {
-	LINUX_2.6 {
-	global:
-		clock_gettime;
-		__vdso_clock_gettime;
-		gettimeofday;
-		__vdso_gettimeofday;
-		getcpu;
-		__vdso_getcpu;
-		time;
-		__vdso_time;
-		clock_getres;
-		__vdso_clock_getres;
-#ifdef CONFIG_X86_SGX
-		__vdso_sgx_enter_enclave;
-#endif
-		getrandom;
-		__vdso_getrandom;
-	local: *;
-	};
-}
diff --git a/arch/x86/entry/vdso/vdso32/Makefile b/arch/x86/entry/vdso/vdso32=
/Makefile
new file mode 100644
index 0000000..add6afb
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso32/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# 32-bit vDSO images for x86.
+#
+
+# The vDSOs built in this directory
+vdsos-y			:=3D 32
+
+# Files to link into the vDSO:
+vobjs-y			:=3D note.o vclock_gettime.o vgetcpu.o
+vobjs-y			+=3D system_call.o sigreturn.o
+
+# Compilation flags
+flags-y			:=3D -DBUILD_VDSO32 -m32 -mregparm=3D0
+flags-$(CONFIG_X86_64)	+=3D -include $(src)/fake_32bit_build.h
+flags-remove-y          :=3D -m64
+
+# The location of this include matters!
+include $(src)/../common/Makefile.include
+
+# Linker options for the vdso
+VDSO_LDFLAGS_32		:=3D -m elf_i386 -soname linux-gate.so.1
+
+$(obj)/vdso32.so.dbg: $(vobjs)
diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/n=
ote.S
index 2cbd399..62d8aa5 100644
--- a/arch/x86/entry/vdso/vdso32/note.S
+++ b/arch/x86/entry/vdso/vdso32/note.S
@@ -1,18 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This supplies .note.* sections to go into the PT_NOTE inside the vDSO tex=
t.
- * Here we can supply some information useful to userland.
- */
-
-#include <linux/build-salt.h>
-#include <linux/version.h>
-#include <linux/elfnote.h>
-
-/* Ideally this would use UTS_NAME, but using a quoted string here
-   doesn't work. Remember to change this when changing the
-   kernel's name. */
-ELFNOTE_START(Linux, 0, "a")
-	.long LINUX_VERSION_CODE
-ELFNOTE_END
-
-BUILD_SALT
+#include "common/note.S"
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/v=
dso32/system_call.S
index d33c651..2a15634 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -52,7 +52,7 @@ __kernel_vsyscall:
 	#define SYSENTER_SEQUENCE	"movl %esp, %ebp; sysenter"
 	#define SYSCALL_SEQUENCE	"movl %ecx, %ebp; syscall"
=20
-#ifdef CONFIG_X86_64
+#ifdef BUILD_VDSO32_64
 	/* If SYSENTER (Intel) or SYSCALL32 (AMD) is available, use it. */
 	ALTERNATIVE_2 "", SYSENTER_SEQUENCE, X86_FEATURE_SYSENTER32, \
 	                  SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vds=
o/vdso32/vclock_gettime.c
index 86981de..1481f00 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -1,4 +1 @@
-// SPDX-License-Identifier: GPL-2.0
-#define BUILD_VDSO32
-#include "fake_32bit_build.h"
-#include "../vclock_gettime.c"
+#include "common/vclock_gettime.c"
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vd=
so32/vdso32.lds.S
index 8a3be07..8a85354 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -11,7 +11,7 @@
=20
 #define BUILD_VDSO32
=20
-#include "../vdso-layout.lds.S"
+#include "common/vdso-layout.lds.S"
=20
 /* The ELF entry point can be used to set the AT_SYSINFO value.  */
 ENTRY(__kernel_vsyscall);
diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vdso3=
2/vgetcpu.c
index 3a9791f..00cc832 100644
--- a/arch/x86/entry/vdso/vdso32/vgetcpu.c
+++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
@@ -1,3 +1 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "fake_32bit_build.h"
-#include "../vgetcpu.c"
+#include "common/vgetcpu.c"
diff --git a/arch/x86/entry/vdso/vdso64/Makefile b/arch/x86/entry/vdso/vdso64=
/Makefile
new file mode 100644
index 0000000..bfffaf1
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/Makefile
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# 64-bit vDSO images for x86.
+#
+
+# The vDSOs built in this directory
+vdsos-y				:=3D 64
+vdsos-$(CONFIG_X86_X32_ABI)	+=3D x32
+
+# Files to link into the vDSO:
+vobjs-y				:=3D note.o vclock_gettime.o vgetcpu.o
+vobjs-y				+=3D vgetrandom.o vgetrandom-chacha.o
+vobjs-$(CONFIG_X86_SGX)		+=3D vsgx.o
+
+# Compilation flags
+flags-y				:=3D -DBUILD_VDSO64 -m64 -mcmodel=3Dsmall
+
+# The location of this include matters!
+include $(src)/../common/Makefile.include
+
+#
+# X32 processes use x32 vDSO to access 64bit kernel data.
+#
+# Build x32 vDSO image:
+# 1. Compile x32 vDSO as 64bit.
+# 2. Convert object files to x32.
+# 3. Build x32 VDSO image with x32 objects, which contains 64bit codes
+# so that it can reach 64bit address space with 64bit pointers.
+#
+
+# Convert 64bit object file to x32 for x32 vDSO.
+quiet_cmd_x32 =3D X32     $@
+      cmd_x32 =3D $(OBJCOPY) -O elf32-x86-64 $< $@
+
+$(obj)/%-x32.o: $(obj)/%.o FORCE
+	$(call if_changed,x32)
+
+vobjsx32 =3D $(patsubst %.o,%-x32.o,$(vobjs))
+targets +=3D $(patsubst %.o,%-x32.o,$(vobjs-y))
+
+# Linker options for the vdso
+VDSO_LDFLAGS_64  :=3D -m elf_x86_64 -soname linux-vdso.so.1 -z max-page-size=
=3D4096
+VDSO_LDFLAGS_x32 :=3D $(subst elf_x86_64,elf32_x86_64,$(VDSO_LDFLAGS_64))
+
+$(obj)/vdso64.so.dbg:	$(vobjs)
+$(obj)/vdsox32.so.dbg:	$(vobjsx32)
diff --git a/arch/x86/entry/vdso/vdso64/note.S b/arch/x86/entry/vdso/vdso64/n=
ote.S
new file mode 100644
index 0000000..62d8aa5
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/note.S
@@ -0,0 +1 @@
+#include "common/note.S"
diff --git a/arch/x86/entry/vdso/vdso64/vclock_gettime.c b/arch/x86/entry/vds=
o/vdso64/vclock_gettime.c
new file mode 100644
index 0000000..1481f00
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vclock_gettime.c
@@ -0,0 +1 @@
+#include "common/vclock_gettime.c"
diff --git a/arch/x86/entry/vdso/vdso64/vdso64.lds.S b/arch/x86/entry/vdso/vd=
so64/vdso64.lds.S
new file mode 100644
index 0000000..5ce3f2b
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linker script for 64-bit vDSO.
+ * We #include the file to define the layout details.
+ *
+ * This file defines the version script giving the user-exported symbols in
+ * the DSO.
+ */
+
+#define BUILD_VDSO64
+
+#include "common/vdso-layout.lds.S"
+
+/*
+ * This controls what userland symbols we export from the vDSO.
+ */
+VERSION {
+	LINUX_2.6 {
+	global:
+		clock_gettime;
+		__vdso_clock_gettime;
+		gettimeofday;
+		__vdso_gettimeofday;
+		getcpu;
+		__vdso_getcpu;
+		time;
+		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
+#ifdef CONFIG_X86_SGX
+		__vdso_sgx_enter_enclave;
+#endif
+		getrandom;
+		__vdso_getrandom;
+	local: *;
+	};
+}
diff --git a/arch/x86/entry/vdso/vdso64/vdsox32.lds.S b/arch/x86/entry/vdso/v=
dso64/vdsox32.lds.S
new file mode 100644
index 0000000..3dbd20c
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vdsox32.lds.S
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linker script for x32 vDSO.
+ * We #include the file to define the layout details.
+ *
+ * This file defines the version script giving the user-exported symbols in
+ * the DSO.
+ */
+
+#define BUILD_VDSOX32
+
+#include "common/vdso-layout.lds.S"
+
+/*
+ * This controls what userland symbols we export from the vDSO.
+ */
+VERSION {
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+		__vdso_getcpu;
+		__vdso_time;
+		__vdso_clock_getres;
+	local: *;
+	};
+}
diff --git a/arch/x86/entry/vdso/vdso64/vgetcpu.c b/arch/x86/entry/vdso/vdso6=
4/vgetcpu.c
new file mode 100644
index 0000000..00cc832
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vgetcpu.c
@@ -0,0 +1 @@
+#include "common/vgetcpu.c"
diff --git a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S b/arch/x86/entry/=
vdso/vdso64/vgetrandom-chacha.S
new file mode 100644
index 0000000..bcba563
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights =
Reserved.
+ */
+
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+.section	.rodata, "a"
+.align 16
+CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
+.text
+
+/*
+ * Very basic SSE2 implementation of ChaCha20. Produces a given positive num=
ber
+ * of blocks of output with a nonce of 0, taking an input key and 8-byte
+ * counter. Importantly does not spill to the stack. Its arguments are:
+ *
+ *	rdi: output bytes
+ *	rsi: 32-byte key input
+ *	rdx: 8-byte counter input/output
+ *	rcx: number of 64-byte blocks to write to output
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+
+.set	output,		%rdi
+.set	key,		%rsi
+.set	counter,	%rdx
+.set	nblocks,	%rcx
+.set	i,		%al
+/* xmm registers are *not* callee-save. */
+.set	temp,		%xmm0
+.set	state0,		%xmm1
+.set	state1,		%xmm2
+.set	state2,		%xmm3
+.set	state3,		%xmm4
+.set	copy0,		%xmm5
+.set	copy1,		%xmm6
+.set	copy2,		%xmm7
+.set	copy3,		%xmm8
+.set	one,		%xmm9
+
+	/* copy0 =3D "expand 32-byte k" */
+	movaps		CONSTANTS(%rip),copy0
+	/* copy1,copy2 =3D key */
+	movups		0x00(key),copy1
+	movups		0x10(key),copy2
+	/* copy3 =3D counter || zero nonce */
+	movq		0x00(counter),copy3
+	/* one =3D 1 || 0 */
+	movq		$1,%rax
+	movq		%rax,one
+
+.Lblock:
+	/* state0,state1,state2,state3 =3D copy0,copy1,copy2,copy3 */
+	movdqa		copy0,state0
+	movdqa		copy1,state1
+	movdqa		copy2,state2
+	movdqa		copy3,state3
+
+	movb		$10,i
+.Lpermute:
+	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] =3D state1[1,2,3,0] */
+	pshufd		$0x39,state1,state1
+	/* state2[0,1,2,3] =3D state2[2,3,0,1] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] =3D state3[3,0,1,2] */
+	pshufd		$0x93,state3,state3
+
+	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] =3D state1[3,0,1,2] */
+	pshufd		$0x93,state1,state1
+	/* state2[0,1,2,3] =3D state2[2,3,0,1] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] =3D state3[1,2,3,0] */
+	pshufd		$0x39,state3,state3
+
+	decb		i
+	jnz		.Lpermute
+
+	/* output0 =3D state0 + copy0 */
+	paddd		copy0,state0
+	movups		state0,0x00(output)
+	/* output1 =3D state1 + copy1 */
+	paddd		copy1,state1
+	movups		state1,0x10(output)
+	/* output2 =3D state2 + copy2 */
+	paddd		copy2,state2
+	movups		state2,0x20(output)
+	/* output3 =3D state3 + copy3 */
+	paddd		copy3,state3
+	movups		state3,0x30(output)
+
+	/* ++copy3.counter */
+	paddq		one,copy3
+
+	/* output +=3D 64, --nblocks */
+	addq		$64,output
+	decq		nblocks
+	jnz		.Lblock
+
+	/* counter =3D copy3.counter */
+	movq		copy3,0x00(counter)
+
+	/* Zero out the potentially sensitive regs, in case nothing uses these agai=
n. */
+	pxor		state0,state0
+	pxor		state1,state1
+	pxor		state2,state2
+	pxor		state3,state3
+	pxor		copy1,copy1
+	pxor		copy2,copy2
+	pxor		temp,temp
+
+	ret
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vdso64/vgetrandom.c b/arch/x86/entry/vdso/vd=
so64/vgetrandom.c
new file mode 100644
index 0000000..6a95d36
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vgetrandom.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights =
Reserved.
+ */
+#include <linux/types.h>
+
+#include "lib/vdso/getrandom.c"
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void =
*opaque_state, size_t opaque_len)
+{
+	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
+}
+
+ssize_t getrandom(void *, size_t, unsigned int, void *, size_t)
+	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/v=
sgx.S
new file mode 100644
index 0000000..37a3d4c
--- /dev/null
+++ b/arch/x86/entry/vdso/vdso64/vsgx.S
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/linkage.h>
+#include <asm/errno.h>
+#include <asm/enclu.h>
+
+#include "extable.h"
+
+/* Relative to %rbp. */
+#define SGX_ENCLAVE_OFFSET_OF_RUN		16
+
+/* The offsets relative to struct sgx_enclave_run. */
+#define SGX_ENCLAVE_RUN_TCS			0
+#define SGX_ENCLAVE_RUN_LEAF			8
+#define SGX_ENCLAVE_RUN_EXCEPTION_VECTOR	12
+#define SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE	14
+#define SGX_ENCLAVE_RUN_EXCEPTION_ADDR		16
+#define SGX_ENCLAVE_RUN_USER_HANDLER		24
+#define SGX_ENCLAVE_RUN_USER_DATA		32	/* not used */
+#define SGX_ENCLAVE_RUN_RESERVED_START		40
+#define SGX_ENCLAVE_RUN_RESERVED_END		256
+
+.code64
+.section .text, "ax"
+
+SYM_FUNC_START(__vdso_sgx_enter_enclave)
+	/* Prolog */
+	.cfi_startproc
+	push	%rbp
+	.cfi_adjust_cfa_offset	8
+	.cfi_rel_offset		%rbp, 0
+	mov	%rsp, %rbp
+	.cfi_def_cfa_register	%rbp
+	push	%rbx
+	.cfi_rel_offset		%rbx, -8
+
+	mov	%ecx, %eax
+.Lenter_enclave:
+	/* EENTER <=3D function <=3D ERESUME */
+	cmp	$EENTER, %eax
+	jb	.Linvalid_input
+	cmp	$ERESUME, %eax
+	ja	.Linvalid_input
+
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rcx
+
+	/* Validate that the reserved area contains only zeros. */
+	mov	$SGX_ENCLAVE_RUN_RESERVED_START, %rbx
+1:
+	cmpq	$0, (%rcx, %rbx)
+	jne	.Linvalid_input
+	add	$8, %rbx
+	cmpq	$SGX_ENCLAVE_RUN_RESERVED_END, %rbx
+	jne	1b
+
+	/* Load TCS and AEP */
+	mov	SGX_ENCLAVE_RUN_TCS(%rcx), %rbx
+	lea	.Lasync_exit_pointer(%rip), %rcx
+
+	/* Single ENCLU serving as both EENTER and AEP (ERESUME) */
+.Lasync_exit_pointer:
+.Lenclu_eenter_eresume:
+	enclu
+
+	/* EEXIT jumps here unless the enclave is doing something fancy. */
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
+
+	/* Set exit_reason. */
+	movl	$EEXIT, SGX_ENCLAVE_RUN_LEAF(%rbx)
+
+	/* Invoke userspace's exit handler if one was provided. */
+.Lhandle_exit:
+	cmpq	$0, SGX_ENCLAVE_RUN_USER_HANDLER(%rbx)
+	jne	.Linvoke_userspace_handler
+
+	/* Success, in the sense that ENCLU was attempted. */
+	xor	%eax, %eax
+
+.Lout:
+	pop	%rbx
+	leave
+	.cfi_def_cfa		%rsp, 8
+	RET
+
+	/* The out-of-line code runs with the pre-leave stack frame. */
+	.cfi_def_cfa		%rbp, 16
+
+.Linvalid_input:
+	mov	$(-EINVAL), %eax
+	jmp	.Lout
+
+.Lhandle_exception:
+	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
+
+	/* Set the exception info. */
+	mov	%eax, (SGX_ENCLAVE_RUN_LEAF)(%rbx)
+	mov	%di,  (SGX_ENCLAVE_RUN_EXCEPTION_VECTOR)(%rbx)
+	mov	%si,  (SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE)(%rbx)
+	mov	%rdx, (SGX_ENCLAVE_RUN_EXCEPTION_ADDR)(%rbx)
+	jmp	.Lhandle_exit
+
+.Linvoke_userspace_handler:
+	/* Pass the untrusted RSP (at exit) to the callback via %rcx. */
+	mov	%rsp, %rcx
+
+	/* Save struct sgx_enclave_exception %rbx is about to be clobbered. */
+	mov	%rbx, %rax
+
+	/* Save the untrusted RSP offset in %rbx (non-volatile register). */
+	mov	%rsp, %rbx
+	and	$0xf, %rbx
+
+	/*
+	 * Align stack per x86_64 ABI. Note, %rsp needs to be 16-byte aligned
+	 * _after_ pushing the parameters on the stack, hence the bonus push.
+	 */
+	and	$-0x10, %rsp
+	push	%rax
+
+	/* Push struct sgx_enclave_exception as a param to the callback. */
+	push	%rax
+
+	/* Clear RFLAGS.DF per x86_64 ABI */
+	cld
+
+	/*
+	 * Load the callback pointer to %rax and lfence for LVI (load value
+	 * injection) protection before making the call.
+	 */
+	mov	SGX_ENCLAVE_RUN_USER_HANDLER(%rax), %rax
+	lfence
+	call	*%rax
+
+	/* Undo the post-exit %rsp adjustment. */
+	lea	0x10(%rsp, %rbx), %rsp
+
+	/*
+	 * If the return from callback is zero or negative, return immediately,
+	 * else re-execute ENCLU with the positive return value interpreted as
+	 * the requested ENCLU function.
+	 */
+	cmp	$0, %eax
+	jle	.Lout
+	jmp	.Lenter_enclave
+
+	.cfi_endproc
+
+_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
+
+SYM_FUNC_END(__vdso_sgx_enter_enclave)
diff --git a/arch/x86/entry/vdso/vdsox32.lds.S b/arch/x86/entry/vdso/vdsox32.=
lds.S
deleted file mode 100644
index 16a8050..0000000
--- a/arch/x86/entry/vdso/vdsox32.lds.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Linker script for x32 vDSO.
- * We #include the file to define the layout details.
- *
- * This file defines the version script giving the user-exported symbols in
- * the DSO.
- */
-
-#define BUILD_VDSOX32
-
-#include "vdso-layout.lds.S"
-
-/*
- * This controls what userland symbols we export from the vDSO.
- */
-VERSION {
-	LINUX_2.6 {
-	global:
-		__vdso_clock_gettime;
-		__vdso_gettimeofday;
-		__vdso_getcpu;
-		__vdso_time;
-		__vdso_clock_getres;
-	local: *;
-	};
-}
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
deleted file mode 100644
index e464030..0000000
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2006 Andi Kleen, SUSE Labs.
- *
- * Fast user context implementation of getcpu()
- */
-
-#include <linux/kernel.h>
-#include <linux/getcpu.h>
-#include <asm/segment.h>
-#include <vdso/processor.h>
-
-notrace long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
-{
-	vdso_read_cpunode(cpu, node);
-
-	return 0;
-}
-
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
-	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vg=
etrandom-chacha.S
deleted file mode 100644
index bcba563..0000000
--- a/arch/x86/entry/vdso/vgetrandom-chacha.S
+++ /dev/null
@@ -1,178 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights =
Reserved.
- */
-
-#include <linux/linkage.h>
-#include <asm/frame.h>
-
-.section	.rodata, "a"
-.align 16
-CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
-.text
-
-/*
- * Very basic SSE2 implementation of ChaCha20. Produces a given positive num=
ber
- * of blocks of output with a nonce of 0, taking an input key and 8-byte
- * counter. Importantly does not spill to the stack. Its arguments are:
- *
- *	rdi: output bytes
- *	rsi: 32-byte key input
- *	rdx: 8-byte counter input/output
- *	rcx: number of 64-byte blocks to write to output
- */
-SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-
-.set	output,		%rdi
-.set	key,		%rsi
-.set	counter,	%rdx
-.set	nblocks,	%rcx
-.set	i,		%al
-/* xmm registers are *not* callee-save. */
-.set	temp,		%xmm0
-.set	state0,		%xmm1
-.set	state1,		%xmm2
-.set	state2,		%xmm3
-.set	state3,		%xmm4
-.set	copy0,		%xmm5
-.set	copy1,		%xmm6
-.set	copy2,		%xmm7
-.set	copy3,		%xmm8
-.set	one,		%xmm9
-
-	/* copy0 =3D "expand 32-byte k" */
-	movaps		CONSTANTS(%rip),copy0
-	/* copy1,copy2 =3D key */
-	movups		0x00(key),copy1
-	movups		0x10(key),copy2
-	/* copy3 =3D counter || zero nonce */
-	movq		0x00(counter),copy3
-	/* one =3D 1 || 0 */
-	movq		$1,%rax
-	movq		%rax,one
-
-.Lblock:
-	/* state0,state1,state2,state3 =3D copy0,copy1,copy2,copy3 */
-	movdqa		copy0,state0
-	movdqa		copy1,state1
-	movdqa		copy2,state2
-	movdqa		copy3,state3
-
-	movb		$10,i
-.Lpermute:
-	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 16) */
-	paddd		state1,state0
-	pxor		state0,state3
-	movdqa		state3,temp
-	pslld		$16,temp
-	psrld		$16,state3
-	por		temp,state3
-
-	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 12) */
-	paddd		state3,state2
-	pxor		state2,state1
-	movdqa		state1,temp
-	pslld		$12,temp
-	psrld		$20,state1
-	por		temp,state1
-
-	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 8) */
-	paddd		state1,state0
-	pxor		state0,state3
-	movdqa		state3,temp
-	pslld		$8,temp
-	psrld		$24,state3
-	por		temp,state3
-
-	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 7) */
-	paddd		state3,state2
-	pxor		state2,state1
-	movdqa		state1,temp
-	pslld		$7,temp
-	psrld		$25,state1
-	por		temp,state1
-
-	/* state1[0,1,2,3] =3D state1[1,2,3,0] */
-	pshufd		$0x39,state1,state1
-	/* state2[0,1,2,3] =3D state2[2,3,0,1] */
-	pshufd		$0x4e,state2,state2
-	/* state3[0,1,2,3] =3D state3[3,0,1,2] */
-	pshufd		$0x93,state3,state3
-
-	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 16) */
-	paddd		state1,state0
-	pxor		state0,state3
-	movdqa		state3,temp
-	pslld		$16,temp
-	psrld		$16,state3
-	por		temp,state3
-
-	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 12) */
-	paddd		state3,state2
-	pxor		state2,state1
-	movdqa		state1,temp
-	pslld		$12,temp
-	psrld		$20,state1
-	por		temp,state1
-
-	/* state0 +=3D state1, state3 =3D rotl32(state3 ^ state0, 8) */
-	paddd		state1,state0
-	pxor		state0,state3
-	movdqa		state3,temp
-	pslld		$8,temp
-	psrld		$24,state3
-	por		temp,state3
-
-	/* state2 +=3D state3, state1 =3D rotl32(state1 ^ state2, 7) */
-	paddd		state3,state2
-	pxor		state2,state1
-	movdqa		state1,temp
-	pslld		$7,temp
-	psrld		$25,state1
-	por		temp,state1
-
-	/* state1[0,1,2,3] =3D state1[3,0,1,2] */
-	pshufd		$0x93,state1,state1
-	/* state2[0,1,2,3] =3D state2[2,3,0,1] */
-	pshufd		$0x4e,state2,state2
-	/* state3[0,1,2,3] =3D state3[1,2,3,0] */
-	pshufd		$0x39,state3,state3
-
-	decb		i
-	jnz		.Lpermute
-
-	/* output0 =3D state0 + copy0 */
-	paddd		copy0,state0
-	movups		state0,0x00(output)
-	/* output1 =3D state1 + copy1 */
-	paddd		copy1,state1
-	movups		state1,0x10(output)
-	/* output2 =3D state2 + copy2 */
-	paddd		copy2,state2
-	movups		state2,0x20(output)
-	/* output3 =3D state3 + copy3 */
-	paddd		copy3,state3
-	movups		state3,0x30(output)
-
-	/* ++copy3.counter */
-	paddq		one,copy3
-
-	/* output +=3D 64, --nblocks */
-	addq		$64,output
-	decq		nblocks
-	jnz		.Lblock
-
-	/* counter =3D copy3.counter */
-	movq		copy3,0x00(counter)
-
-	/* Zero out the potentially sensitive regs, in case nothing uses these agai=
n. */
-	pxor		state0,state0
-	pxor		state1,state1
-	pxor		state2,state2
-	pxor		state3,state3
-	pxor		copy1,copy1
-	pxor		copy2,copy2
-	pxor		temp,temp
-
-	ret
-SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrando=
m.c
deleted file mode 100644
index 430862b..0000000
--- a/arch/x86/entry/vdso/vgetrandom.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights =
Reserved.
- */
-#include <linux/types.h>
-
-#include "../../../../lib/vdso/getrandom.c"
-
-ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void =
*opaque_state, size_t opaque_len)
-{
-	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
-}
-
-ssize_t getrandom(void *, size_t, unsigned int, void *, size_t)
-	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
deleted file mode 100644
index 37a3d4c..0000000
--- a/arch/x86/entry/vdso/vsgx.S
+++ /dev/null
@@ -1,150 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#include <linux/linkage.h>
-#include <asm/errno.h>
-#include <asm/enclu.h>
-
-#include "extable.h"
-
-/* Relative to %rbp. */
-#define SGX_ENCLAVE_OFFSET_OF_RUN		16
-
-/* The offsets relative to struct sgx_enclave_run. */
-#define SGX_ENCLAVE_RUN_TCS			0
-#define SGX_ENCLAVE_RUN_LEAF			8
-#define SGX_ENCLAVE_RUN_EXCEPTION_VECTOR	12
-#define SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE	14
-#define SGX_ENCLAVE_RUN_EXCEPTION_ADDR		16
-#define SGX_ENCLAVE_RUN_USER_HANDLER		24
-#define SGX_ENCLAVE_RUN_USER_DATA		32	/* not used */
-#define SGX_ENCLAVE_RUN_RESERVED_START		40
-#define SGX_ENCLAVE_RUN_RESERVED_END		256
-
-.code64
-.section .text, "ax"
-
-SYM_FUNC_START(__vdso_sgx_enter_enclave)
-	/* Prolog */
-	.cfi_startproc
-	push	%rbp
-	.cfi_adjust_cfa_offset	8
-	.cfi_rel_offset		%rbp, 0
-	mov	%rsp, %rbp
-	.cfi_def_cfa_register	%rbp
-	push	%rbx
-	.cfi_rel_offset		%rbx, -8
-
-	mov	%ecx, %eax
-.Lenter_enclave:
-	/* EENTER <=3D function <=3D ERESUME */
-	cmp	$EENTER, %eax
-	jb	.Linvalid_input
-	cmp	$ERESUME, %eax
-	ja	.Linvalid_input
-
-	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rcx
-
-	/* Validate that the reserved area contains only zeros. */
-	mov	$SGX_ENCLAVE_RUN_RESERVED_START, %rbx
-1:
-	cmpq	$0, (%rcx, %rbx)
-	jne	.Linvalid_input
-	add	$8, %rbx
-	cmpq	$SGX_ENCLAVE_RUN_RESERVED_END, %rbx
-	jne	1b
-
-	/* Load TCS and AEP */
-	mov	SGX_ENCLAVE_RUN_TCS(%rcx), %rbx
-	lea	.Lasync_exit_pointer(%rip), %rcx
-
-	/* Single ENCLU serving as both EENTER and AEP (ERESUME) */
-.Lasync_exit_pointer:
-.Lenclu_eenter_eresume:
-	enclu
-
-	/* EEXIT jumps here unless the enclave is doing something fancy. */
-	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
-
-	/* Set exit_reason. */
-	movl	$EEXIT, SGX_ENCLAVE_RUN_LEAF(%rbx)
-
-	/* Invoke userspace's exit handler if one was provided. */
-.Lhandle_exit:
-	cmpq	$0, SGX_ENCLAVE_RUN_USER_HANDLER(%rbx)
-	jne	.Linvoke_userspace_handler
-
-	/* Success, in the sense that ENCLU was attempted. */
-	xor	%eax, %eax
-
-.Lout:
-	pop	%rbx
-	leave
-	.cfi_def_cfa		%rsp, 8
-	RET
-
-	/* The out-of-line code runs with the pre-leave stack frame. */
-	.cfi_def_cfa		%rbp, 16
-
-.Linvalid_input:
-	mov	$(-EINVAL), %eax
-	jmp	.Lout
-
-.Lhandle_exception:
-	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
-
-	/* Set the exception info. */
-	mov	%eax, (SGX_ENCLAVE_RUN_LEAF)(%rbx)
-	mov	%di,  (SGX_ENCLAVE_RUN_EXCEPTION_VECTOR)(%rbx)
-	mov	%si,  (SGX_ENCLAVE_RUN_EXCEPTION_ERROR_CODE)(%rbx)
-	mov	%rdx, (SGX_ENCLAVE_RUN_EXCEPTION_ADDR)(%rbx)
-	jmp	.Lhandle_exit
-
-.Linvoke_userspace_handler:
-	/* Pass the untrusted RSP (at exit) to the callback via %rcx. */
-	mov	%rsp, %rcx
-
-	/* Save struct sgx_enclave_exception %rbx is about to be clobbered. */
-	mov	%rbx, %rax
-
-	/* Save the untrusted RSP offset in %rbx (non-volatile register). */
-	mov	%rsp, %rbx
-	and	$0xf, %rbx
-
-	/*
-	 * Align stack per x86_64 ABI. Note, %rsp needs to be 16-byte aligned
-	 * _after_ pushing the parameters on the stack, hence the bonus push.
-	 */
-	and	$-0x10, %rsp
-	push	%rax
-
-	/* Push struct sgx_enclave_exception as a param to the callback. */
-	push	%rax
-
-	/* Clear RFLAGS.DF per x86_64 ABI */
-	cld
-
-	/*
-	 * Load the callback pointer to %rax and lfence for LVI (load value
-	 * injection) protection before making the call.
-	 */
-	mov	SGX_ENCLAVE_RUN_USER_HANDLER(%rax), %rax
-	lfence
-	call	*%rax
-
-	/* Undo the post-exit %rsp adjustment. */
-	lea	0x10(%rsp, %rbx), %rsp
-
-	/*
-	 * If the return from callback is zero or negative, return immediately,
-	 * else re-execute ENCLU with the positive return value interpreted as
-	 * the requested ENCLU function.
-	 */
-	cmp	$0, %eax
-	jle	.Lout
-	jmp	.Lenter_enclave
-
-	.cfi_endproc
-
-_ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
-
-SYM_FUNC_END(__vdso_sgx_enter_enclave)

