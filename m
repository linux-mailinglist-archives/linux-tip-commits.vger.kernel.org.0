Return-Path: <linux-tip-commits+bounces-3557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8AA3EF7B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5783C422F57
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC820551C;
	Fri, 21 Feb 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5GCNCyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kafZPKr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87776204C14;
	Fri, 21 Feb 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128600; cv=none; b=uOW0zr+YkEC0K3HEVeO0sF/G2qPDPLRsdb8N4atlD8AwbQkTtd9dfNntJVnL6v4q11iw+Eq4B5iFvieL+B+wAB6RFWsyhv29tX+wN5lXx6/z/GFOr6c7F/WjBt6i3rs2ftYt/j+Wkc43jd4QqvycHTdDjvrofSwDBxIOx/so6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128600; c=relaxed/simple;
	bh=OCksay0ceh+i4TVVvCkZx8lBcRbp8xwWSYF6kOEGkWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nBNl/7oMzV4sULgl0wRHgpYI6k741T80EgM8ySOrNWYwvAY4onREgog71y//i2Rj3RDe2rE6StjFAD+kxZevwtiJOTTvtD6IXIaX0Cc9Ji5Tulk8hH68SUwZbhNknL1wbVOrzmp9f2XHBLa805NpOjhXW8/zbFo5LBLE++Uej8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5GCNCyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kafZPKr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LiguCf2f10bkYVbNKJbhJKDmhHqriqusEBzMY5769k=;
	b=z5GCNCyCh74gMWCZ0rUvIwaKRGUcJX2Cw8FNQsiryOaGAJohxEw6cP1bvT0LTShUQHzaeX
	/vm3tmSooHC/g7R1IWDmw7QEnszpAqVO6jdJf8nkgBeZGlfu4LTquQp8etZTst91YvPWWw
	0PpWtqD9vQFZ7GfNU8TSmMHcQJ3DUahXpB2N7A6pLtGHbZ6efNM2Eaqm4iLQvjSszvEVgV
	+0u+tULO6o2j1X8WtDwjQZYjy1HTQUZzZWbMG806mG8oF/+5Ec2QwSpT0blJGnjcWTKwfX
	oeFVZU6gh6rTOfFSv/jVzAG5Uc8QTDdrKKqvqBvzR4VrNJaWwb/q9izkxx9Owg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LiguCf2f10bkYVbNKJbhJKDmhHqriqusEBzMY5769k=;
	b=4kafZPKrW9fhmpE70IyPeyr8WBr5odoW4P41c9yF+P3IuOht7ZMnj/Pn4Z3UYVgEMjs4Uf
	DGIeq/0/DSgVPqAw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Rename included Makefile
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-4-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-4-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859557.10177.1965914486493850628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     127b0e05c1669d240426719b3b9db8a8366eed50
Gitweb:        https://git.kernel.org/tip/127b0e05c1669d240426719b3b9db8a8366=
eed50
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

vdso: Rename included Makefile

As the Makefile is included into other Makefiles it can not be used to
define objects to be built from the current source directory.
However the generic datastore will introduce such a local source file.
Rename the included Makefile so it is clear how it is to be used and to
make room for a regular Makefile in lib/vdso/.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-4-13a4669dfc8c@l=
inutronix.de

---
 arch/arm/vdso/Makefile             |  2 +-
 arch/arm64/kernel/vdso/Makefile    |  2 +-
 arch/arm64/kernel/vdso32/Makefile  |  2 +-
 arch/csky/kernel/vdso/Makefile     |  2 +-
 arch/loongarch/vdso/Makefile       |  2 +-
 arch/mips/vdso/Makefile            |  2 +-
 arch/parisc/kernel/vdso32/Makefile |  2 +-
 arch/parisc/kernel/vdso64/Makefile |  2 +-
 arch/powerpc/kernel/vdso/Makefile  |  2 +-
 arch/riscv/kernel/vdso/Makefile    |  2 +-
 arch/s390/kernel/vdso32/Makefile   |  2 +-
 arch/s390/kernel/vdso64/Makefile   |  2 +-
 arch/x86/entry/vdso/Makefile       |  2 +-
 lib/vdso/Makefile                  | 18 ------------------
 lib/vdso/Makefile.include          | 18 ++++++++++++++++++
 15 files changed, 31 insertions(+), 31 deletions(-)
 delete mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/Makefile.include

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 8a306bb..cb044bf 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 hostprogs :=3D vdsomunge
=20
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 35685c0..5e27e46 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -7,7 +7,7 @@
 #
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso :=3D vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-cha=
cha.o
=20
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Mak=
efile
index 25a2cb6..f2dfdc7 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -3,7 +3,7 @@
 # Makefile for vdso32
 #
=20
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Same as cc-*option, but using CC_COMPAT instead of CC
 ifeq ($(CONFIG_CC_IS_CLANG), y)
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index 069ef0b..a304228 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Symbols present in the vdso
 vdso-syms  +=3D rt_sigreturn
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bc..1c26147 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -2,7 +2,7 @@
 # Objects to go into the VDSO.
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso-y :=3D elf.o vgetcpu.o vgettimeofday.o vgetrandom.o \
               vgetrandom-chacha.o sigreturn.o
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index b289b2c..fb4c493 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -2,7 +2,7 @@
 # Objects to go into the VDSO.
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso-y :=3D elf.o vgettimeofday.o sigreturn.o
=20
diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/M=
akefile
index 288f8b8..4ee8d17 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -1,5 +1,5 @@
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 KCOV_INSTRUMENT :=3D n
=20
diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vdso64/M=
akefile
index bc5d955..c63f406 100644
--- a/arch/parisc/kernel/vdso64/Makefile
+++ b/arch/parisc/kernel/vdso64/Makefile
@@ -1,5 +1,5 @@
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 KCOV_INSTRUMENT :=3D n
=20
diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Mak=
efile
index 0e3ed6f..e8824f9 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -3,7 +3,7 @@
 # List of files in the vdso, has to be asm only for now
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 obj-vdso32 =3D sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32=
.o note-32.o getcpu-32.o
 obj-vdso64 =3D sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64=
.o note-64.o getcpu-64.o
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9a1b555..ad73607 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -2,7 +2,7 @@
 # Copied from arch/tile/kernel/vdso/Makefile
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 # Symbols present in the vdso
 vdso-syms  =3D rt_sigreturn
 ifdef CONFIG_64BIT
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makef=
ile
index 2c5afb8..1e4ddd1 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -2,7 +2,7 @@
 # List of files in the vdso
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 obj-vdso32 =3D vdso_user_wrapper-32.o note-32.o
=20
 # Build rules
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makef=
ile
index ad206f2..d8f0df7 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -2,7 +2,7 @@
 # List of files in the vdso
=20
 # Include the generic Makefile to check the built vdso.
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
 obj-vdso64 =3D vdso_user_wrapper.o note.o vgetrandom-chacha.o
 obj-cvdso64 =3D vdso64_generic.o getcpu.o vgetrandom.o
 VDSO_CFLAGS_REMOVE :=3D -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac..1c00723 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -4,7 +4,7 @@
 #
=20
 # Include the generic Makefile to check the built vDSO:
-include $(srctree)/lib/vdso/Makefile
+include $(srctree)/lib/vdso/Makefile.include
=20
 # Files to link into the vDSO:
 vobjs-y :=3D vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o vgetrandom-=
chacha.o
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
deleted file mode 100644
index cedbf15..0000000
--- a/lib/vdso/Makefile
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-GENERIC_VDSO_MK_PATH :=3D $(abspath $(lastword $(MAKEFILE_LIST)))
-GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))
-
-c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) :=3D $(addprefix $(GENERIC_VDS=
O_DIR), gettimeofday.c)
-c-getrandom-$(CONFIG_VDSO_GETRANDOM) :=3D $(addprefix $(GENERIC_VDSO_DIR), g=
etrandom.c)
-
-# This cmd checks that the vdso library does not contain dynamic relocations.
-# It has to be called after the linking of the vdso library and requires it
-# as a parameter.
-#
-# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
-# dynamic relocations, ignore R_*_NONE.
-quiet_cmd_vdso_check =3D VDSOCHK $@
-      cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
-		       then (echo >&2 "$@: dynamic relocations are not supported"; \
-			     rm -f $@; /bin/false); fi
diff --git a/lib/vdso/Makefile.include b/lib/vdso/Makefile.include
new file mode 100644
index 0000000..cedbf15
--- /dev/null
+++ b/lib/vdso/Makefile.include
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+GENERIC_VDSO_MK_PATH :=3D $(abspath $(lastword $(MAKEFILE_LIST)))
+GENERIC_VDSO_DIR :=3D $(dir $(GENERIC_VDSO_MK_PATH))
+
+c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) :=3D $(addprefix $(GENERIC_VDS=
O_DIR), gettimeofday.c)
+c-getrandom-$(CONFIG_VDSO_GETRANDOM) :=3D $(addprefix $(GENERIC_VDSO_DIR), g=
etrandom.c)
+
+# This cmd checks that the vdso library does not contain dynamic relocations.
+# It has to be called after the linking of the vdso library and requires it
+# as a parameter.
+#
+# As a workaround for some GNU ld ports which produce unneeded R_*_NONE
+# dynamic relocations, ignore R_*_NONE.
+quiet_cmd_vdso_check =3D VDSOCHK $@
+      cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q " R_=
\w*_"; \
+		       then (echo >&2 "$@: dynamic relocations are not supported"; \
+			     rm -f $@; /bin/false); fi

