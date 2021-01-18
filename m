Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F562FABFE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbhARU7V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 15:59:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55258 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389757AbhARKOj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:39 -0500
Date:   Mon, 18 Jan 2021 10:13:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SLXC/QKJGdOvBfJ5FFfWhLvgnOgSnNPLZC5qm9RGKnw=;
        b=I3fbCc3j0RTVv2wiVw52ATy0ed/hgSYTKkPjjMdT+Cq5+yuKWfbldJmWtEax6LjYS7iEhf
        L64pIUrE2wqxkrfuv1FaRRgrIA9ALu4Emj792IVg+hiGsB5NGqqG12O1a6zRZopBvk7bUz
        AQXlGsYtvEH/I0eV0XC171ewbhJcoaYaO985EOAHlyTEE7Cg8bWd8t2dtD8KxH0vF3tOG0
        Bt5zP0VDZYpi019omSbLMKG+DUPy6tTFZ46FBsyrvzPwuSlIpIGer5b/EYag75Pq8qNwAW
        d+Tv+VbNnXcni6J3U1WzL1Sr+j25wwkZY2HAdrZnUNqAeq8jOSvPkZeAo3/fQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SLXC/QKJGdOvBfJ5FFfWhLvgnOgSnNPLZC5qm9RGKnw=;
        b=lSr1W4Tg3TqY/G/eFiHm5RDKX5ReqsmowD4mldzzLqffUKJ239QzVQBeFy5M4eT2eomFBp
        yeYdAtozdMDNpuBg==
From:   "tip-bot2 for Vasily Gorbik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/insn: Fix vector instruction decoding on big
 endian cross-compiles
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481083.414.18147299871024079886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5ed934e57e712b676ca62e1904ad672a9fa1505a
Gitweb:        https://git.kernel.org/tip/5ed934e57e712b676ca62e1904ad672a9fa1505a
Author:        Vasily Gorbik <gor@linux.ibm.com>
AuthorDate:    Fri, 13 Nov 2020 17:09:54 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:17 -06:00

x86/insn: Fix vector instruction decoding on big endian cross-compiles

Running instruction decoder posttest on an s390 host with an x86 target
with allyesconfig shows errors. Instructions used in a couple of kernel
objects could not be correctly decoded on big endian system.

  insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 5
  insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  insn_decoder_test: warning: ffffffff831eb4e1:    62 d1 fd 48 7f 04 24    vmovdqa64 %zmm0,(%r12)
  insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
  insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
  insn_decoder_test: warning: ffffffff831eb4e8:    62 51 fd 48 7f 44 24 01         vmovdqa64 %zmm8,0x40(%r12)
  insn_decoder_test: warning: objdump says 8 bytes, but insn_get_length() says 6

This is because in a few places instruction field bytes are set directly
with further usage of "value". To address that introduce and use a
insn_set_byte() helper, which correctly updates "value" on big endian
systems.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/insn.h       | 12 ++++++++++++
 arch/x86/lib/insn.c               | 18 +++++++++---------
 tools/arch/x86/include/asm/insn.h | 12 ++++++++++++
 tools/arch/x86/lib/insn.c         | 18 +++++++++---------
 4 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 090863c..95a448f 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -30,6 +30,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
 #else
 
 struct insn_field {
@@ -51,6 +57,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
 #endif
 
 struct insn {
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 520b31f..435630a 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -161,9 +161,9 @@ found:
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -194,13 +194,13 @@ found:
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -208,7 +208,7 @@ found:
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -220,7 +220,7 @@ found:
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -256,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index c1fab7a..cc777c1 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -30,6 +30,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+}
+
 #else
 
 struct insn_field {
@@ -51,6 +57,12 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 	p->nbytes = n;
 }
 
+static inline void insn_set_byte(struct insn_field *p, unsigned char n,
+				 insn_byte_t v)
+{
+	p->bytes[n] = v;
+	p->value = __le32_to_cpu(p->little);
+}
 #endif
 
 struct insn {
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 77e92aa..3d9355e 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -161,9 +161,9 @@ found:
 			b = insn->prefixes.bytes[3];
 			for (i = 0; i < nb; i++)
 				if (prefixes->bytes[i] == lb)
-					prefixes->bytes[i] = b;
+					insn_set_byte(prefixes, i, b);
 		}
-		insn->prefixes.bytes[3] = lb;
+		insn_set_byte(&insn->prefixes, 3, lb);
 	}
 
 	/* Decode REX prefix */
@@ -194,13 +194,13 @@ found:
 			if (X86_MODRM_MOD(b2) != 3)
 				goto vex_end;
 		}
-		insn->vex_prefix.bytes[0] = b;
-		insn->vex_prefix.bytes[1] = b2;
+		insn_set_byte(&insn->vex_prefix, 0, b);
+		insn_set_byte(&insn->vex_prefix, 1, b2);
 		if (inat_is_evex_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			b2 = peek_nbyte_next(insn_byte_t, insn, 3);
-			insn->vex_prefix.bytes[3] = b2;
+			insn_set_byte(&insn->vex_prefix, 3, b2);
 			insn->vex_prefix.nbytes = 4;
 			insn->next_byte += 4;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -208,7 +208,7 @@ found:
 				insn->opnd_bytes = 8;
 		} else if (inat_is_vex3_prefix(attr)) {
 			b2 = peek_nbyte_next(insn_byte_t, insn, 2);
-			insn->vex_prefix.bytes[2] = b2;
+			insn_set_byte(&insn->vex_prefix, 2, b2);
 			insn->vex_prefix.nbytes = 3;
 			insn->next_byte += 3;
 			if (insn->x86_64 && X86_VEX_W(b2))
@@ -220,7 +220,7 @@ found:
 			 * Makes it easier to decode vex.W, vex.vvvv,
 			 * vex.L and vex.pp. Masking with 0x7f sets vex.W == 0.
 			 */
-			insn->vex_prefix.bytes[2] = b2 & 0x7f;
+			insn_set_byte(&insn->vex_prefix, 2, b2 & 0x7f);
 			insn->vex_prefix.nbytes = 2;
 			insn->next_byte += 2;
 		}
@@ -256,7 +256,7 @@ void insn_get_opcode(struct insn *insn)
 
 	/* Get first opcode */
 	op = get_next(insn_byte_t, insn);
-	opcode->bytes[0] = op;
+	insn_set_byte(opcode, 0, op);
 	opcode->nbytes = 1;
 
 	/* Check if there is VEX prefix or not */
