Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B7F49754F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jan 2022 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiAWTo4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 Jan 2022 14:44:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiAWToz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 Jan 2022 14:44:55 -0500
Date:   Sun, 23 Jan 2022 19:44:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642967094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1meVO5lrjft6NsXyGfiNyAFxIRzeuqJeCTu7gvicFvE=;
        b=aMlBLO4FJtkIDzmO9yoMhD+qNAIcwRF8csI33ZQ6tE+0qZ0SVflzM+Otzcm6Y+BHBDvfX5
        jg1QanQS5jUGAledDK7FISCiv7VkEmGEwgCAfNIYkj0LnN4vjDcn7KdLdAyVZRrhiiBEJx
        ln0zct+wYM9kOyPPe+l5lgfBoBnlQfodYNK9XjqYRJYmVg29HitmnxXlVvBlHMJtiP/kBN
        XzH/UmBq+zFGXiP0lu8HYIsWd7k5ecFMKb+y7Wcxn1MK+pnHRfPa70cDvh3kKfCZUnpzea
        6trSAWRzhsCe+BSnp8F8NK///dJ8IyPfRFM0PocN4x6UyXbZM5+336vNMIaMDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642967094;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1meVO5lrjft6NsXyGfiNyAFxIRzeuqJeCTu7gvicFvE=;
        b=I3mw/FjJlLMQ8eYmVb7EuwIt1UFv/acuclcWXNbZxcWabMbaOqnYzWCFZ89enqSSyKxXph
        pbRMHs5NJKoWG5DA==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/insn: Add AVX512-FP16 instructions to the x86
 instruction decoder
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202095029.2165714-7-adrian.hunter@intel.com>
References: <20211202095029.2165714-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164296709318.16921.7836678925763420554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     16273fa4f3a2dc2c64dd8a28fe30f255a4de0e4c
Gitweb:        https://git.kernel.org/tip/16273fa4f3a2dc2c64dd8a28fe30f255a4de0e4c
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 02 Dec 2021 11:50:29 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 23 Jan 2022 20:38:01 +01:00

x86/insn: Add AVX512-FP16 instructions to the x86 instruction decoder

The x86 instruction decoder is used for both kernel instructions and
user space instructions (e.g. uprobes, perf tools Intel PT), so it is
good to update it with new instructions.

Add AVX512-FP16 instructions to x86 instruction decoder.

Note the EVEX map field is extended by 1 bit, and most instructions are in
map 5 and map 6.

Reference:
Intel AVX512-FP16 Architecture Specification
June 2021
Revision 1.0
Document Number: 347407-001US

Example using perf tools' x86 instruction decoder test:

  $ perf test -v "x86 instruction decoder" |& grep vfcmaddcph | head -2
  Decoded ok: 62 f6 6f 48 56 cb           vfcmaddcph %zmm3,%zmm2,%zmm1
  Decoded ok: 62 f6 6f 48 56 8c c8 78 56 34 12    vfcmaddcph 0x12345678(%eax,%ecx,8),%zmm2,%zmm1

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20211202095029.2165714-7-adrian.hunter@intel.com
---
 arch/x86/include/asm/insn.h           |  2 +-
 arch/x86/lib/x86-opcode-map.txt       | 95 +++++++++++++++++++++++---
 tools/arch/x86/include/asm/insn.h     |  2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 95 +++++++++++++++++++++++---
 4 files changed, 176 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 05a6ab9..1b29f58 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -124,7 +124,7 @@ struct insn {
 #define X86_VEX_B(vex)	((vex) & 0x20)	/* VEX3 Byte1 */
 #define X86_VEX_L(vex)	((vex) & 0x04)	/* VEX3 Byte2, VEX2 Byte1 */
 /* VEX bit fields */
-#define X86_EVEX_M(vex)	((vex) & 0x03)		/* EVEX Byte1 */
+#define X86_EVEX_M(vex)	((vex) & 0x07)		/* EVEX Byte1 */
 #define X86_VEX3_M(vex)	((vex) & 0x1f)		/* VEX3 Byte1 */
 #define X86_VEX2_M	1			/* VEX2.M always 1 */
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 591797a..d12d135 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -828,9 +828,9 @@ AVXcode: 3
 05: vpermilpd Vx,Wx,Ib (66),(v)
 06: vperm2f128 Vqq,Hqq,Wqq,Ib (66),(v)
 07:
-08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo)
+08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo) | vrndscaleph Vx,Wx,Ib (evo)
 09: vroundpd Vx,Wx,Ib (66) | vrndscalepd Vx,Wx,Ib (66),(evo)
-0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo)
+0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo) | vrndscalesh Vx,Hx,Wx,Ib (evo)
 0b: vroundsd Vsd,Wsd,Ib (66),(v1) | vrndscalesd Vx,Hx,Wx,Ib (66),(evo)
 0c: vblendps Vx,Hx,Wx,Ib (66)
 0d: vblendpd Vx,Hx,Wx,Ib (66)
@@ -852,8 +852,8 @@ AVXcode: 3
 22: vpinsrd/q Vdq,Hdq,Ey,Ib (66),(v1)
 23: vshuff32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
 25: vpternlogd/q Vx,Hx,Wx,Ib (66),(ev)
-26: vgetmantps/d Vx,Wx,Ib (66),(ev)
-27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev)
+26: vgetmantps/d Vx,Wx,Ib (66),(ev) | vgetmantph Vx,Wx,Ib (ev)
+27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev) | vgetmantsh Vx,Hx,Wx,Ib (ev)
 30: kshiftrb/w Vk,Uk,Ib (66),(v)
 31: kshiftrd/q Vk,Uk,Ib (66),(v)
 32: kshiftlb/w Vk,Uk,Ib (66),(v)
@@ -877,18 +877,19 @@ AVXcode: 3
 51: vrangess/d Vx,Hx,Wx,Ib (66),(ev)
 54: vfixupimmps/d Vx,Hx,Wx,Ib (66),(ev)
 55: vfixupimmss/d Vx,Hx,Wx,Ib (66),(ev)
-56: vreduceps/d Vx,Wx,Ib (66),(ev)
-57: vreducess/d Vx,Hx,Wx,Ib (66),(ev)
+56: vreduceps/d Vx,Wx,Ib (66),(ev) | vreduceph Vx,Wx,Ib (ev)
+57: vreducess/d Vx,Hx,Wx,Ib (66),(ev) | vreducesh Vx,Hx,Wx,Ib (ev)
 60: vpcmpestrm Vdq,Wdq,Ib (66),(v1)
 61: vpcmpestri Vdq,Wdq,Ib (66),(v1)
 62: vpcmpistrm Vdq,Wdq,Ib (66),(v1)
 63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
-66: vfpclassps/d Vk,Wx,Ib (66),(ev)
-67: vfpclassss/d Vk,Wx,Ib (66),(ev)
+66: vfpclassps/d Vk,Wx,Ib (66),(ev) | vfpclassph Vx,Wx,Ib (ev)
+67: vfpclassss/d Vk,Wx,Ib (66),(ev) | vfpclasssh Vx,Wx,Ib (ev)
 70: vpshldw Vx,Hx,Wx,Ib (66),(ev)
 71: vpshldd/q Vx,Hx,Wx,Ib (66),(ev)
 72: vpshrdw Vx,Hx,Wx,Ib (66),(ev)
 73: vpshrdd/q Vx,Hx,Wx,Ib (66),(ev)
+c2: vcmpph Vx,Hx,Wx,Ib (ev) | vcmpsh Vx,Hx,Wx,Ib (F3),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
@@ -896,6 +897,84 @@ df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
+Table: EVEX map 5
+Referrer:
+AVXcode: 5
+10: vmovsh Vx,Hx,Wx (F3),(ev) | vmovsh Vx,Wx (F3),(ev)
+11: vmovsh Wx,Hx,Vx (F3),(ev) | vmovsh Wx,Vx (F3),(ev)
+1d: vcvtps2phx Vx,Wx (66),(ev) | vcvtss2sh Vx,Hx,Wx (ev)
+2a: vcvtsi2sh Vx,Hx,Wx (F3),(ev)
+2c: vcvttsh2si Vx,Wx (F3),(ev)
+2d: vcvtsh2si Vx,Wx (F3),(ev)
+2e: vucomish Vx,Wx (ev)
+2f: vcomish Vx,Wx (ev)
+51: vsqrtph Vx,Wx (ev) | vsqrtsh Vx,Hx,Wx (F3),(ev)
+58: vaddph Vx,Hx,Wx (ev) | vaddsh Vx,Hx,Wx (F3),(ev)
+59: vmulph Vx,Hx,Wx (ev) | vmulsh Vx,Hx,Wx (F3),(ev)
+5a: vcvtpd2ph Vx,Wx (66),(ev) | vcvtph2pd Vx,Wx (ev) | vcvtsd2sh Vx,Hx,Wx (F2),(ev) | vcvtsh2sd Vx,Hx,Wx (F3),(ev)
+5b: vcvtdq2ph Vx,Wx (ev) | vcvtph2dq Vx,Wx (66),(ev) | vcvtqq2ph Vx,Wx (ev) | vcvttph2dq Vx,Wx (F3),(ev)
+5c: vsubph Vx,Hx,Wx (ev) | vsubsh Vx,Hx,Wx (F3),(ev)
+5d: vminph Vx,Hx,Wx (ev) | vminsh Vx,Hx,Wx (F3),(ev)
+5e: vdivph Vx,Hx,Wx (ev) | vdivsh Vx,Hx,Wx (F3),(ev)
+5f: vmaxph Vx,Hx,Wx (ev) | vmaxsh Vx,Hx,Wx (F3),(ev)
+6e: vmovw Vx,Wx (66),(ev)
+78: vcvttph2udq Vx,Wx (ev) | vcvttph2uqq Vx,Wx (66),(ev) | vcvttsh2usi Vx,Wx (F3),(ev)
+79: vcvtph2udq Vx,Wx (ev) | vcvtph2uqq Vx,Wx (66),(ev) | vcvtsh2usi Vx,Wx (F3),(ev)
+7a: vcvttph2qq Vx,Wx (66),(ev) | vcvtudq2ph Vx,Wx (F2),(ev) | vcvtuqq2ph Vx,Wx (F2),(ev)
+7b: vcvtph2qq Vx,Wx (66),(ev) | vcvtusi2sh Vx,Hx,Wx (F3),(ev)
+7c: vcvttph2uw Vx,Wx (ev) | vcvttph2w Vx,Wx (66),(ev)
+7d: vcvtph2uw Vx,Wx (ev) | vcvtph2w Vx,Wx (66),(ev) | vcvtuw2ph Vx,Wx (F2),(ev) | vcvtw2ph Vx,Wx (F3),(ev)
+7e: vmovw Wx,Vx (66),(ev)
+EndTable
+
+Table: EVEX map 6
+Referrer:
+AVXcode: 6
+13: vcvtph2psx Vx,Wx (66),(ev) | vcvtsh2ss Vx,Hx,Wx (ev)
+2c: vscalefph Vx,Hx,Wx (66),(ev)
+2d: vscalefsh Vx,Hx,Wx (66),(ev)
+42: vgetexpph Vx,Wx (66),(ev)
+43: vgetexpsh Vx,Hx,Wx (66),(ev)
+4c: vrcpph Vx,Wx (66),(ev)
+4d: vrcpsh Vx,Hx,Wx (66),(ev)
+4e: vrsqrtph Vx,Wx (66),(ev)
+4f: vrsqrtsh Vx,Hx,Wx (66),(ev)
+56: vfcmaddcph Vx,Hx,Wx (F2),(ev) | vfmaddcph Vx,Hx,Wx (F3),(ev)
+57: vfcmaddcsh Vx,Hx,Wx (F2),(ev) | vfmaddcsh Vx,Hx,Wx (F3),(ev)
+96: vfmaddsub132ph Vx,Hx,Wx (66),(ev)
+97: vfmsubadd132ph Vx,Hx,Wx (66),(ev)
+98: vfmadd132ph Vx,Hx,Wx (66),(ev)
+99: vfmadd132sh Vx,Hx,Wx (66),(ev)
+9a: vfmsub132ph Vx,Hx,Wx (66),(ev)
+9b: vfmsub132sh Vx,Hx,Wx (66),(ev)
+9c: vfnmadd132ph Vx,Hx,Wx (66),(ev)
+9d: vfnmadd132sh Vx,Hx,Wx (66),(ev)
+9e: vfnmsub132ph Vx,Hx,Wx (66),(ev)
+9f: vfnmsub132sh Vx,Hx,Wx (66),(ev)
+a6: vfmaddsub213ph Vx,Hx,Wx (66),(ev)
+a7: vfmsubadd213ph Vx,Hx,Wx (66),(ev)
+a8: vfmadd213ph Vx,Hx,Wx (66),(ev)
+a9: vfmadd213sh Vx,Hx,Wx (66),(ev)
+aa: vfmsub213ph Vx,Hx,Wx (66),(ev)
+ab: vfmsub213sh Vx,Hx,Wx (66),(ev)
+ac: vfnmadd213ph Vx,Hx,Wx (66),(ev)
+ad: vfnmadd213sh Vx,Hx,Wx (66),(ev)
+ae: vfnmsub213ph Vx,Hx,Wx (66),(ev)
+af: vfnmsub213sh Vx,Hx,Wx (66),(ev)
+b6: vfmaddsub231ph Vx,Hx,Wx (66),(ev)
+b7: vfmsubadd231ph Vx,Hx,Wx (66),(ev)
+b8: vfmadd231ph Vx,Hx,Wx (66),(ev)
+b9: vfmadd231sh Vx,Hx,Wx (66),(ev)
+ba: vfmsub231ph Vx,Hx,Wx (66),(ev)
+bb: vfmsub231sh Vx,Hx,Wx (66),(ev)
+bc: vfnmadd231ph Vx,Hx,Wx (66),(ev)
+bd: vfnmadd231sh Vx,Hx,Wx (66),(ev)
+be: vfnmsub231ph Vx,Hx,Wx (66),(ev)
+bf: vfnmsub231sh Vx,Hx,Wx (66),(ev)
+d6: vfcmulcph Vx,Hx,Wx (F2),(ev) | vfmulcph Vx,Hx,Wx (F3),(ev)
+d7: vfcmulcsh Vx,Hx,Wx (F2),(ev) | vfmulcsh Vx,Hx,Wx (F3),(ev)
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index dc632b4..65c0d9c 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -124,7 +124,7 @@ struct insn {
 #define X86_VEX_B(vex)	((vex) & 0x20)	/* VEX3 Byte1 */
 #define X86_VEX_L(vex)	((vex) & 0x04)	/* VEX3 Byte2, VEX2 Byte1 */
 /* VEX bit fields */
-#define X86_EVEX_M(vex)	((vex) & 0x03)		/* EVEX Byte1 */
+#define X86_EVEX_M(vex)	((vex) & 0x07)		/* EVEX Byte1 */
 #define X86_VEX3_M(vex)	((vex) & 0x1f)		/* VEX3 Byte1 */
 #define X86_VEX2_M	1			/* VEX2.M always 1 */
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 591797a..d12d135 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -828,9 +828,9 @@ AVXcode: 3
 05: vpermilpd Vx,Wx,Ib (66),(v)
 06: vperm2f128 Vqq,Hqq,Wqq,Ib (66),(v)
 07:
-08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo)
+08: vroundps Vx,Wx,Ib (66) | vrndscaleps Vx,Wx,Ib (66),(evo) | vrndscaleph Vx,Wx,Ib (evo)
 09: vroundpd Vx,Wx,Ib (66) | vrndscalepd Vx,Wx,Ib (66),(evo)
-0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo)
+0a: vroundss Vss,Wss,Ib (66),(v1) | vrndscaless Vx,Hx,Wx,Ib (66),(evo) | vrndscalesh Vx,Hx,Wx,Ib (evo)
 0b: vroundsd Vsd,Wsd,Ib (66),(v1) | vrndscalesd Vx,Hx,Wx,Ib (66),(evo)
 0c: vblendps Vx,Hx,Wx,Ib (66)
 0d: vblendpd Vx,Hx,Wx,Ib (66)
@@ -852,8 +852,8 @@ AVXcode: 3
 22: vpinsrd/q Vdq,Hdq,Ey,Ib (66),(v1)
 23: vshuff32x4/64x2 Vx,Hx,Wx,Ib (66),(ev)
 25: vpternlogd/q Vx,Hx,Wx,Ib (66),(ev)
-26: vgetmantps/d Vx,Wx,Ib (66),(ev)
-27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev)
+26: vgetmantps/d Vx,Wx,Ib (66),(ev) | vgetmantph Vx,Wx,Ib (ev)
+27: vgetmantss/d Vx,Hx,Wx,Ib (66),(ev) | vgetmantsh Vx,Hx,Wx,Ib (ev)
 30: kshiftrb/w Vk,Uk,Ib (66),(v)
 31: kshiftrd/q Vk,Uk,Ib (66),(v)
 32: kshiftlb/w Vk,Uk,Ib (66),(v)
@@ -877,18 +877,19 @@ AVXcode: 3
 51: vrangess/d Vx,Hx,Wx,Ib (66),(ev)
 54: vfixupimmps/d Vx,Hx,Wx,Ib (66),(ev)
 55: vfixupimmss/d Vx,Hx,Wx,Ib (66),(ev)
-56: vreduceps/d Vx,Wx,Ib (66),(ev)
-57: vreducess/d Vx,Hx,Wx,Ib (66),(ev)
+56: vreduceps/d Vx,Wx,Ib (66),(ev) | vreduceph Vx,Wx,Ib (ev)
+57: vreducess/d Vx,Hx,Wx,Ib (66),(ev) | vreducesh Vx,Hx,Wx,Ib (ev)
 60: vpcmpestrm Vdq,Wdq,Ib (66),(v1)
 61: vpcmpestri Vdq,Wdq,Ib (66),(v1)
 62: vpcmpistrm Vdq,Wdq,Ib (66),(v1)
 63: vpcmpistri Vdq,Wdq,Ib (66),(v1)
-66: vfpclassps/d Vk,Wx,Ib (66),(ev)
-67: vfpclassss/d Vk,Wx,Ib (66),(ev)
+66: vfpclassps/d Vk,Wx,Ib (66),(ev) | vfpclassph Vx,Wx,Ib (ev)
+67: vfpclassss/d Vk,Wx,Ib (66),(ev) | vfpclasssh Vx,Wx,Ib (ev)
 70: vpshldw Vx,Hx,Wx,Ib (66),(ev)
 71: vpshldd/q Vx,Hx,Wx,Ib (66),(ev)
 72: vpshrdw Vx,Hx,Wx,Ib (66),(ev)
 73: vpshrdd/q Vx,Hx,Wx,Ib (66),(ev)
+c2: vcmpph Vx,Hx,Wx,Ib (ev) | vcmpsh Vx,Hx,Wx,Ib (F3),(ev)
 cc: sha1rnds4 Vdq,Wdq,Ib
 ce: vgf2p8affineqb Vx,Wx,Ib (66)
 cf: vgf2p8affineinvqb Vx,Wx,Ib (66)
@@ -896,6 +897,84 @@ df: VAESKEYGEN Vdq,Wdq,Ib (66),(v1)
 f0: RORX Gy,Ey,Ib (F2),(v) | HRESET Gv,Ib (F3),(000),(11B)
 EndTable
 
+Table: EVEX map 5
+Referrer:
+AVXcode: 5
+10: vmovsh Vx,Hx,Wx (F3),(ev) | vmovsh Vx,Wx (F3),(ev)
+11: vmovsh Wx,Hx,Vx (F3),(ev) | vmovsh Wx,Vx (F3),(ev)
+1d: vcvtps2phx Vx,Wx (66),(ev) | vcvtss2sh Vx,Hx,Wx (ev)
+2a: vcvtsi2sh Vx,Hx,Wx (F3),(ev)
+2c: vcvttsh2si Vx,Wx (F3),(ev)
+2d: vcvtsh2si Vx,Wx (F3),(ev)
+2e: vucomish Vx,Wx (ev)
+2f: vcomish Vx,Wx (ev)
+51: vsqrtph Vx,Wx (ev) | vsqrtsh Vx,Hx,Wx (F3),(ev)
+58: vaddph Vx,Hx,Wx (ev) | vaddsh Vx,Hx,Wx (F3),(ev)
+59: vmulph Vx,Hx,Wx (ev) | vmulsh Vx,Hx,Wx (F3),(ev)
+5a: vcvtpd2ph Vx,Wx (66),(ev) | vcvtph2pd Vx,Wx (ev) | vcvtsd2sh Vx,Hx,Wx (F2),(ev) | vcvtsh2sd Vx,Hx,Wx (F3),(ev)
+5b: vcvtdq2ph Vx,Wx (ev) | vcvtph2dq Vx,Wx (66),(ev) | vcvtqq2ph Vx,Wx (ev) | vcvttph2dq Vx,Wx (F3),(ev)
+5c: vsubph Vx,Hx,Wx (ev) | vsubsh Vx,Hx,Wx (F3),(ev)
+5d: vminph Vx,Hx,Wx (ev) | vminsh Vx,Hx,Wx (F3),(ev)
+5e: vdivph Vx,Hx,Wx (ev) | vdivsh Vx,Hx,Wx (F3),(ev)
+5f: vmaxph Vx,Hx,Wx (ev) | vmaxsh Vx,Hx,Wx (F3),(ev)
+6e: vmovw Vx,Wx (66),(ev)
+78: vcvttph2udq Vx,Wx (ev) | vcvttph2uqq Vx,Wx (66),(ev) | vcvttsh2usi Vx,Wx (F3),(ev)
+79: vcvtph2udq Vx,Wx (ev) | vcvtph2uqq Vx,Wx (66),(ev) | vcvtsh2usi Vx,Wx (F3),(ev)
+7a: vcvttph2qq Vx,Wx (66),(ev) | vcvtudq2ph Vx,Wx (F2),(ev) | vcvtuqq2ph Vx,Wx (F2),(ev)
+7b: vcvtph2qq Vx,Wx (66),(ev) | vcvtusi2sh Vx,Hx,Wx (F3),(ev)
+7c: vcvttph2uw Vx,Wx (ev) | vcvttph2w Vx,Wx (66),(ev)
+7d: vcvtph2uw Vx,Wx (ev) | vcvtph2w Vx,Wx (66),(ev) | vcvtuw2ph Vx,Wx (F2),(ev) | vcvtw2ph Vx,Wx (F3),(ev)
+7e: vmovw Wx,Vx (66),(ev)
+EndTable
+
+Table: EVEX map 6
+Referrer:
+AVXcode: 6
+13: vcvtph2psx Vx,Wx (66),(ev) | vcvtsh2ss Vx,Hx,Wx (ev)
+2c: vscalefph Vx,Hx,Wx (66),(ev)
+2d: vscalefsh Vx,Hx,Wx (66),(ev)
+42: vgetexpph Vx,Wx (66),(ev)
+43: vgetexpsh Vx,Hx,Wx (66),(ev)
+4c: vrcpph Vx,Wx (66),(ev)
+4d: vrcpsh Vx,Hx,Wx (66),(ev)
+4e: vrsqrtph Vx,Wx (66),(ev)
+4f: vrsqrtsh Vx,Hx,Wx (66),(ev)
+56: vfcmaddcph Vx,Hx,Wx (F2),(ev) | vfmaddcph Vx,Hx,Wx (F3),(ev)
+57: vfcmaddcsh Vx,Hx,Wx (F2),(ev) | vfmaddcsh Vx,Hx,Wx (F3),(ev)
+96: vfmaddsub132ph Vx,Hx,Wx (66),(ev)
+97: vfmsubadd132ph Vx,Hx,Wx (66),(ev)
+98: vfmadd132ph Vx,Hx,Wx (66),(ev)
+99: vfmadd132sh Vx,Hx,Wx (66),(ev)
+9a: vfmsub132ph Vx,Hx,Wx (66),(ev)
+9b: vfmsub132sh Vx,Hx,Wx (66),(ev)
+9c: vfnmadd132ph Vx,Hx,Wx (66),(ev)
+9d: vfnmadd132sh Vx,Hx,Wx (66),(ev)
+9e: vfnmsub132ph Vx,Hx,Wx (66),(ev)
+9f: vfnmsub132sh Vx,Hx,Wx (66),(ev)
+a6: vfmaddsub213ph Vx,Hx,Wx (66),(ev)
+a7: vfmsubadd213ph Vx,Hx,Wx (66),(ev)
+a8: vfmadd213ph Vx,Hx,Wx (66),(ev)
+a9: vfmadd213sh Vx,Hx,Wx (66),(ev)
+aa: vfmsub213ph Vx,Hx,Wx (66),(ev)
+ab: vfmsub213sh Vx,Hx,Wx (66),(ev)
+ac: vfnmadd213ph Vx,Hx,Wx (66),(ev)
+ad: vfnmadd213sh Vx,Hx,Wx (66),(ev)
+ae: vfnmsub213ph Vx,Hx,Wx (66),(ev)
+af: vfnmsub213sh Vx,Hx,Wx (66),(ev)
+b6: vfmaddsub231ph Vx,Hx,Wx (66),(ev)
+b7: vfmsubadd231ph Vx,Hx,Wx (66),(ev)
+b8: vfmadd231ph Vx,Hx,Wx (66),(ev)
+b9: vfmadd231sh Vx,Hx,Wx (66),(ev)
+ba: vfmsub231ph Vx,Hx,Wx (66),(ev)
+bb: vfmsub231sh Vx,Hx,Wx (66),(ev)
+bc: vfnmadd231ph Vx,Hx,Wx (66),(ev)
+bd: vfnmadd231sh Vx,Hx,Wx (66),(ev)
+be: vfnmsub231ph Vx,Hx,Wx (66),(ev)
+bf: vfnmsub231sh Vx,Hx,Wx (66),(ev)
+d6: vfcmulcph Vx,Hx,Wx (F2),(ev) | vfmulcph Vx,Hx,Wx (F3),(ev)
+d7: vfcmulcsh Vx,Hx,Wx (F2),(ev) | vfmulcsh Vx,Hx,Wx (F3),(ev)
+EndTable
+
 GrpTable: Grp1
 0: ADD
 1: OR
