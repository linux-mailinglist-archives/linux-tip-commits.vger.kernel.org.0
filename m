Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC526425F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJJgz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:36:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgIJJW1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:27 -0400
Date:   Thu, 10 Sep 2020 09:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA4tlg2njTohukM65NAP0aZkJKvv1mBtF1U20Qk+Q7c=;
        b=DoLR2kRHFcgNtysmDRZDT4bGgDPBaz2zDRm7paB8qOp6Imj/v4yqyCKgEBznSpEb5oDQ1l
        Fvb/mxNjxsVkRqnl8cupDAF7jPjDdpovFQK1w6WLRLLucA56AodWfziseuQPzBon/Nz7k0
        8xtUTk1X7LxY53RLMqN4uBLaJWXqX2ucp97KKZH1JDQMrbf73Limse+P9LHftFGGj3bh4V
        OFRfBwKTDIuiYzwApR7hEDT7oJjgTiieqP2penwV5hOZzwf5G1s7URDf95cnKG3SsZYu8x
        HyaMdabdhYHgfyd9Tek++6g4MymN6IHhmxefEpLmls0bnnwRYikS+4KjR2JDdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA4tlg2njTohukM65NAP0aZkJKvv1mBtF1U20Qk+Q7c=;
        b=y5AYEWJnapbXph+nF8VXIpfTZAh6AXY2DNVQRdo/gHqCW12l1R7KJ2dR6ZTVFp5pXGzono
        cBX+a4tLGouRZbDg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Add support for handling IOIO exceptions
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-26-joro@8bytes.org>
References: <20200907131613.12703-26-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972974218.20229.18333865131600086102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     25189d08e5168c098c307a0eaae5b30c13a331ef
Gitweb:        https://git.kernel.org/tip/25189d08e5168c098c307a0eaae5b30c13a331ef
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:15:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:26 +02:00

x86/sev-es: Add support for handling IOIO exceptions

Add support for decoding and handling #VC exceptions for IOIO events.

[ jroedel@suse.de: Adapted code to #VC handling framework ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-26-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c |  32 ++++-
 arch/x86/kernel/sev-es-shared.c   | 214 +++++++++++++++++++++++++++++-
 2 files changed, 246 insertions(+)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 1e1fab5..61504eb 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -24,6 +24,35 @@
 struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
 struct ghcb *boot_ghcb;
 
+/*
+ * Copy a version of this function here - insn-eval.c can't be used in
+ * pre-decompression code.
+ */
+static bool insn_has_rep_prefix(struct insn *insn)
+{
+	int i;
+
+	insn_get_prefixes(insn);
+
+	for (i = 0; i < insn->prefixes.nbytes; i++) {
+		insn_byte_t p = insn->prefixes.bytes[i];
+
+		if (p == 0xf2 || p == 0xf3)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
+ * doesn't use segments.
+ */
+static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+{
+	return 0UL;
+}
+
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	unsigned long low, high;
@@ -151,6 +180,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		goto finish;
 
 	switch (exit_code) {
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(boot_ghcb, &ctxt);
+		break;
 	default:
 		result = ES_UNSUPPORTED;
 		break;
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 7ac6e6b..bae7cf2 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -218,3 +218,217 @@ static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
 
 	return ret;
 }
+
+#define IOIO_TYPE_STR  BIT(2)
+#define IOIO_TYPE_IN   1
+#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
+#define IOIO_TYPE_OUT  0
+#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
+
+#define IOIO_REP       BIT(3)
+
+#define IOIO_ADDR_64   BIT(9)
+#define IOIO_ADDR_32   BIT(8)
+#define IOIO_ADDR_16   BIT(7)
+
+#define IOIO_DATA_32   BIT(6)
+#define IOIO_DATA_16   BIT(5)
+#define IOIO_DATA_8    BIT(4)
+
+#define IOIO_SEG_ES    (0 << 10)
+#define IOIO_SEG_DS    (3 << 10)
+
+static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
+{
+	struct insn *insn = &ctxt->insn;
+	*exitinfo = 0;
+
+	switch (insn->opcode.bytes[0]) {
+	/* INS opcodes */
+	case 0x6c:
+	case 0x6d:
+		*exitinfo |= IOIO_TYPE_INS;
+		*exitinfo |= IOIO_SEG_ES;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUTS opcodes */
+	case 0x6e:
+	case 0x6f:
+		*exitinfo |= IOIO_TYPE_OUTS;
+		*exitinfo |= IOIO_SEG_DS;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* IN immediate opcodes */
+	case 0xe4:
+	case 0xe5:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (u64)insn->immediate.value << 16;
+		break;
+
+	/* OUT immediate opcodes */
+	case 0xe6:
+	case 0xe7:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (u64)insn->immediate.value << 16;
+		break;
+
+	/* IN register opcodes */
+	case 0xec:
+	case 0xed:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUT register opcodes */
+	case 0xee:
+	case 0xef:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	default:
+		return ES_DECODE_FAILED;
+	}
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x6c:
+	case 0x6e:
+	case 0xe4:
+	case 0xe6:
+	case 0xec:
+	case 0xee:
+		/* Single byte opcodes */
+		*exitinfo |= IOIO_DATA_8;
+		break;
+	default:
+		/* Length determined by instruction parsing */
+		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
+						     : IOIO_DATA_32;
+	}
+	switch (insn->addr_bytes) {
+	case 2:
+		*exitinfo |= IOIO_ADDR_16;
+		break;
+	case 4:
+		*exitinfo |= IOIO_ADDR_32;
+		break;
+	case 8:
+		*exitinfo |= IOIO_ADDR_64;
+		break;
+	}
+
+	if (insn_has_rep_prefix(insn))
+		*exitinfo |= IOIO_REP;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u64 exit_info_1, exit_info_2;
+	enum es_result ret;
+
+	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
+	if (ret != ES_OK)
+		return ret;
+
+	if (exit_info_1 & IOIO_TYPE_STR) {
+
+		/* (REP) INS/OUTS */
+
+		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
+		unsigned int io_bytes, exit_bytes;
+		unsigned int ghcb_count, op_count;
+		unsigned long es_base;
+		u64 sw_scratch;
+
+		/*
+		 * For the string variants with rep prefix the amount of in/out
+		 * operations per #VC exception is limited so that the kernel
+		 * has a chance to take interrupts and re-schedule while the
+		 * instruction is emulated.
+		 */
+		io_bytes   = (exit_info_1 >> 4) & 0x7;
+		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
+
+		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
+		exit_info_2 = min(op_count, ghcb_count);
+		exit_bytes  = exit_info_2 * io_bytes;
+
+		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+		/* Read bytes of OUTS into the shared buffer */
+		if (!(exit_info_1 & IOIO_TYPE_IN)) {
+			ret = vc_insn_string_read(ctxt,
+					       (void *)(es_base + regs->si),
+					       ghcb->shared_buffer, io_bytes,
+					       exit_info_2, df);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Issue an VMGEXIT to the HV to consume the bytes from the
+		 * shared buffer or to have it write them into the shared buffer
+		 * depending on the instruction: OUTS or INS.
+		 */
+		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
+		ghcb_set_sw_scratch(ghcb, sw_scratch);
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
+					  exit_info_1, exit_info_2);
+		if (ret != ES_OK)
+			return ret;
+
+		/* Read bytes from shared buffer into the guest's destination. */
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			ret = vc_insn_string_write(ctxt,
+						   (void *)(es_base + regs->di),
+						   ghcb->shared_buffer, io_bytes,
+						   exit_info_2, df);
+			if (ret)
+				return ret;
+
+			if (df)
+				regs->di -= exit_bytes;
+			else
+				regs->di += exit_bytes;
+		} else {
+			if (df)
+				regs->si -= exit_bytes;
+			else
+				regs->si += exit_bytes;
+		}
+
+		if (exit_info_1 & IOIO_REP)
+			regs->cx -= exit_info_2;
+
+		ret = regs->cx ? ES_RETRY : ES_OK;
+
+	} else {
+
+		/* IN/OUT into/from rAX */
+
+		int bits = (exit_info_1 & 0x70) >> 1;
+		u64 rax = 0;
+
+		if (!(exit_info_1 & IOIO_TYPE_IN))
+			rax = lower_bits(regs->ax, bits);
+
+		ghcb_set_rax(ghcb, rax);
+
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
+		if (ret != ES_OK)
+			return ret;
+
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			if (!ghcb_rax_is_valid(ghcb))
+				return ES_VMM_ERROR;
+			regs->ax = lower_bits(ghcb->save.rax, bits);
+		}
+	}
+
+	return ret;
+}
