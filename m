Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5239343589
	for <lists+linux-tip-commits@lfdr.de>; Sun, 21 Mar 2021 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCUWxu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 21 Mar 2021 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhCUWxj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 21 Mar 2021 18:53:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655AC061756;
        Sun, 21 Mar 2021 15:53:39 -0700 (PDT)
Date:   Sun, 21 Mar 2021 22:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616367215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YJEZxp4IKDr5QaThTmYCgKywiCfFrfGmeaoIpA5073k=;
        b=E7f9D9C1ABruK6nRYZbudoAibcjuC8OweUyWyTV+lpFc1EeaHIaiUnsjB3DA/Dp/XRZfF/
        OUM6JkH7kN2CUfI7pdvNsH9uF7RG7Ru7P3dgBlewneH4fAGLHe39IaOCVufCyiM9qaNi5E
        mjDLnnNKh/nUDnFjZzCcMm6kuSUlgohkPEVnca613/M+9bCY+iVMVZdXbjOl8S9MU4TipY
        Hf/nKii112G36RgmNlnaokRT1jFJPEX0rQBPcy0bO/ThnCNNwKqMA9OIQb6dmzXrXU0jco
        OEeiP13OYPQHVD8jJ/4OlXIHV9/wTk68EOuxsf+qyjEs5S2SQPV1hZ/+svcyWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616367215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YJEZxp4IKDr5QaThTmYCgKywiCfFrfGmeaoIpA5073k=;
        b=7mQxXWzdehml0VudisU1Jd8o1eb5D1RYxv7TBRAjJkeDBFvUL4dZRrM+9CDVaqZTKTx1rY
        pSM6cD5d4wE8LvCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove unusual Unicode characters from comments
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <161636721493.398.15286526884013721016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c681df88dcb12b1efd7e4efcfe498c5e9c31ce02
Gitweb:        https://git.kernel.org/tip/c681df88dcb12b1efd7e4efcfe498c5e9c3=
1ce02
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sun, 21 Mar 2021 23:32:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 21 Mar 2021 23:50:07 +01:00

x86: Remove unusual Unicode characters from comments

We've accumulated a few unusual Unicode characters in arch/x86/
over the years, substitute them with their proper ASCII equivalents.

A few of them were a whitespace equivalent: '=C2=A0' - the use was harmless.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 arch/x86/include/asm/elf.h           | 10 +++++-----
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/platform/pvh/head.S         |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index b79951d..3241581 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -280,17 +280,17 @@
  * | [63]  |    00h    | VALID - When set, indicates the CPU bus
  *                       numbers have been initialized. (RO)
  * |[62:48]|    ---    | Reserved
- * |[47:40]|    00h    | BUS_NUM_5 =E2=80=94 Return the bus number BIOS assi=
gned
+ * |[47:40]|    00h    | BUS_NUM_5 - Return the bus number BIOS assigned
  *                       CPUBUSNO(5). (RO)
- * |[39:32]|    00h    | BUS_NUM_4 =E2=80=94 Return the bus number BIOS assi=
gned
+ * |[39:32]|    00h    | BUS_NUM_4 - Return the bus number BIOS assigned
  *                       CPUBUSNO(4). (RO)
- * |[31:24]|    00h    | BUS_NUM_3 =E2=80=94 Return the bus number BIOS assi=
gned
+ * |[31:24]|    00h    | BUS_NUM_3 - Return the bus number BIOS assigned
  *                       CPUBUSNO(3). (RO)
- * |[23:16]|    00h    | BUS_NUM_2 =E2=80=94 Return the bus number BIOS assi=
gned
+ * |[23:16]|    00h    | BUS_NUM_2 - Return the bus number BIOS assigned
  *                       CPUBUSNO(2). (RO)
- * |[15:8] |    00h    | BUS_NUM_1 =E2=80=94 Return the bus number BIOS assi=
gned
+ * |[15:8] |    00h    | BUS_NUM_1 - Return the bus number BIOS assigned
  *                       CPUBUSNO(1). (RO)
- * | [7:0] |    00h    | BUS_NUM_0 =E2=80=94 Return the bus number BIOS assi=
gned
+ * | [7:0] |    00h    | BUS_NUM_0 - Return the bus number BIOS assigned
  *                       CPUBUSNO(0). (RO)
  */
 #define SKX_MSR_CPU_BUS_NUMBER		0x300
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9224d40..7d75008 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -283,12 +283,12 @@ extern u32 elf_hwcap2;
  *
  * The decision process for determining the results are:
  *
- * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0    =C2=A0CPU: | lacks NX* =C2=
=A0| has NX, ia32 =C2=A0 =C2=A0 | has NX, x86_64 |
- * ELF: =C2=A0 =C2=A0 =C2=A0 =C2=A0    =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
+ *                 CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
+ * ELF:                 |            |                  |                |
  * ---------------------|------------|------------------|----------------|
- * missing PT_GNU_STACK | exec-all =C2=A0 | exec-all =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | exec-none=C2=A0 =C2=A0 =C2=A0 |
- * PT_GNU_STACK =3D=3D RWX =C2=A0| exec-stack | exec-stack =C2=A0 =C2=A0 =C2=
=A0 | exec-stack =C2=A0 =C2=A0 |
- * PT_GNU_STACK =3D=3D RW =C2=A0 | exec-none =C2=A0| exec-none =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| exec-none =C2=A0 =C2=A0 =C2=A0|
+ * missing PT_GNU_STACK | exec-all   | exec-all         | exec-none      |
+ * PT_GNU_STACK =3D=3D RWX  | exec-stack | exec-stack       | exec-stack    =
 |
+ * PT_GNU_STACK =3D=3D RW   | exec-none  | exec-none        | exec-none     =
 |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index cb9ad6b..d83ea9e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -33,7 +33,7 @@
=20
 /*
  * Google experimented with loop-unrolling and this turned out to be
- * the optimal version =E2=80=94 two calls, each with their own speculation
+ * the optimal version - two calls, each with their own speculation
  * trap should their return address end up getting used, in a loop.
  */
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index d2ccadc..66b3173 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -30,10 +30,10 @@
  *          the boot start info structure.
  * - `cr0`: bit 0 (PE) must be set. All the other writeable bits are cleared.
  * - `cr4`: all bits are cleared.
- * - `cs `: must be a 32-bit read/execute code segment with a base of =E2=80=
=980=E2=80=99
- *          and a limit of =E2=80=980xFFFFFFFF=E2=80=99. The selector value =
is unspecified.
+ * - `cs `: must be a 32-bit read/execute code segment with a base of `0`
+ *          and a limit of `0xFFFFFFFF`. The selector value is unspecified.
  * - `ds`, `es`: must be a 32-bit read/write data segment with a base of
- *               =E2=80=980=E2=80=99 and a limit of =E2=80=980xFFFFFFFF=E2=
=80=99. The selector values are all
+ *               `0` and a limit of `0xFFFFFFFF`. The selector values are all
  *               unspecified.
  * - `tr`: must be a 32-bit TSS (active) with a base of '0' and a limit
  *         of '0x67'.
