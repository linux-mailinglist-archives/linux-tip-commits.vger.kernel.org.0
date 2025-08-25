Return-Path: <linux-tip-commits+bounces-6363-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05DB33CBA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E766E188DAD4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C742E7F25;
	Mon, 25 Aug 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wmw3M/EJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PufcBame"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381572E7634;
	Mon, 25 Aug 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117503; cv=none; b=gYLBm990QqrTlQyRkK0zuwsgp+c9ZAQ3eOZoLSvFCUueAun0lYqO/ad9K+HxBzDBKI9QrYaC2B6gw23FNaCv0Co7i3n7XZnz/moeCCbdLVnddSxeB9ygjkt5frB6jcytHX8MlMzR3bTLzsxHzyQmEawZudsibmI0IeDgVpVG50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117503; c=relaxed/simple;
	bh=WZlZITnT5xn4Z5xn4HrHlgu5D2IcLvFt2JPg1hg770M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Lq0TKTiqXzcNY6xKrUEZY6oyYAGvHOgkI0hR7PoaegRUXGxtUowMlVDNo/z/5EmmXCasa+i/ZCYKGgK2EvdDXIlp01NfS/a8D1qE1a/VRNEkDhe22Ua8l9hEb/sH7/XiQUqm74Fk5R0CbctuOZaP12WDjblePgUafGlLnJsx3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wmw3M/EJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PufcBame; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBhpzbQIWvIc4ppfnTxFSZXXOJcrwKgk31UiHIAxWNk=;
	b=Wmw3M/EJk2PtiqIgbHpvaUrpaXdhBaf2CaWzIM93eZ8t69WIEvrwLxy1AKeJX0x4CTduZ9
	Z/bAR0AG9GgvsFgMtjRaMBWAUXZbGZTGkrAC7/WeN8U4yJQIY0wWL+rYAXPQliBfgQyTFx
	QUMnTiDWIGc+waZXZLhzyOe7CmabEJvtHMwSK4ZAWbRmfaHMtMAVuoBTQPfBXPjPXJA1ob
	R46Y5u6O8Ikok4zWFiKx4drJwdgLCuRJ6Q6tR8iTcBJTrJc6r0IkYbhVHFgxTopH6MPUll
	WT//m1+D5FWKj+672PHJ5GLq545FYpHdkyEUD162UTK8mrqncMlgeDnweOjodg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBhpzbQIWvIc4ppfnTxFSZXXOJcrwKgk31UiHIAxWNk=;
	b=PufcBamemAZN4rkMx0ahmYyjUqGIbclxB82Pw6eAWTUFe4mjubMQNdiqEI5kWhTL+bGilQ
	DtkryUuyJVGQXABw==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Add support to optimize uprobes
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-11-jolsa@kernel.org>
References: <20250720112133.244369-11-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611749830.1420.12577171865927719665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ba2bfc97b4629b10bd8d02b36e04f3932a04cac4
Gitweb:        https://git.kernel.org/tip/ba2bfc97b4629b10bd8d02b36e04f3932a0=
4cac4
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:21 +02:00

uprobes/x86: Add support to optimize uprobes

Putting together all the previously added pieces to support optimized
uprobes on top of 5-byte nop instruction.

The current uprobe execution goes through following:

  - installs breakpoint instruction over original instruction
  - exception handler hit and calls related uprobe consumers
  - and either simulates original instruction or does out of line single step
    execution of it
  - returns to user space

The optimized uprobe path does following:

  - checks the original instruction is 5-byte nop (plus other checks)
  - adds (or uses existing) user space trampoline with uprobe syscall
  - overwrites original instruction (5-byte nop) with call to user space
    trampoline
  - the user space trampoline executes uprobe syscall that calls related upro=
be
    consumers
  - trampoline returns back to next instruction

This approach won't speed up all uprobes as it's limited to using nop5 as
original instruction, but we plan to use nop5 as USDT probe instruction
(which currently uses single byte nop) and speed up the USDT probes.

The arch_uprobe_optimize triggers the uprobe optimization and is called after
first uprobe hit. I originally had it called on uprobe installation but then
it clashed with elf loader, because the user space trampoline was added in a
place where loader might need to put elf segments, so I decided to do it after
first uprobe hit when loading is done.

The uprobe is un-optimized in arch specific set_orig_insn call.

The instruction overwrite is x86 arch specific and needs to go through 3 upda=
tes:
(on top of nop5 instruction)

  - write int3 into 1st byte
  - write last 4 bytes of the call instruction
  - update the call instruction opcode

And cleanup goes though similar reverse stages:

  - overwrite call opcode with breakpoint (int3)
  - write last 4 bytes of the nop5 instruction
  - write the nop5 first instruction byte

We do not unmap and release uprobe trampoline when it's no longer needed,
because there's no easy way to make sure none of the threads is still
inside the trampoline. But we do not waste memory, because there's just
single page for all the uprobe trampoline mappings.

We do waste frame on page mapping for every 4GB by keeping the uprobe
trampoline page mapped, but that seems ok.

We take the benefit from the fact that set_swbp and set_orig_insn are
called under mmap_write_lock(mm), so we can use the current instruction
as the state the uprobe is in - nop5/breakpoint/call trampoline -
and decide the needed action (optimize/un-optimize) based on that.

Attaching the speed up from benchs/run_bench_uprobes.sh script:

current:
        usermode-count :  152.604 =C2=B1 0.044M/s
        syscall-count  :   13.359 =C2=B1 0.042M/s
-->     uprobe-nop     :    3.229 =C2=B1 0.002M/s
        uprobe-push    :    3.086 =C2=B1 0.004M/s
        uprobe-ret     :    1.114 =C2=B1 0.004M/s
        uprobe-nop5    :    1.121 =C2=B1 0.005M/s
        uretprobe-nop  :    2.145 =C2=B1 0.002M/s
        uretprobe-push :    2.070 =C2=B1 0.001M/s
        uretprobe-ret  :    0.931 =C2=B1 0.001M/s
        uretprobe-nop5 :    0.957 =C2=B1 0.001M/s

after the change:
        usermode-count :  152.448 =C2=B1 0.244M/s
        syscall-count  :   14.321 =C2=B1 0.059M/s
        uprobe-nop     :    3.148 =C2=B1 0.007M/s
        uprobe-push    :    2.976 =C2=B1 0.004M/s
        uprobe-ret     :    1.068 =C2=B1 0.003M/s
-->     uprobe-nop5    :    7.038 =C2=B1 0.007M/s
        uretprobe-nop  :    2.109 =C2=B1 0.004M/s
        uretprobe-push :    2.035 =C2=B1 0.001M/s
        uretprobe-ret  :    0.908 =C2=B1 0.001M/s
        uretprobe-nop5 :    3.377 =C2=B1 0.009M/s

I see bit more speed up on Intel (above) compared to AMD. The big nop5
speed up is partly due to emulating nop5 and partly due to optimization.

The key speed up we do this for is the USDT switch from nop to nop5:
        uprobe-nop     :    3.148 =C2=B1 0.007M/s
        uprobe-nop5    :    7.038 =C2=B1 0.007M/s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-11-jolsa@kernel.org
---
 arch/x86/include/asm/uprobes.h |   7 +-
 arch/x86/kernel/uprobes.c      | 283 +++++++++++++++++++++++++++++++-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        |  16 +-
 4 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/uprobes.h b/arch/x86/include/asm/uprobes.h
index 678fb54..1ee2e51 100644
--- a/arch/x86/include/asm/uprobes.h
+++ b/arch/x86/include/asm/uprobes.h
@@ -20,6 +20,11 @@ typedef u8 uprobe_opcode_t;
 #define UPROBE_SWBP_INSN		0xcc
 #define UPROBE_SWBP_INSN_SIZE		   1
=20
+enum {
+	ARCH_UPROBE_FLAG_CAN_OPTIMIZE   =3D 0,
+	ARCH_UPROBE_FLAG_OPTIMIZE_FAIL  =3D 1,
+};
+
 struct uprobe_xol_ops;
=20
 struct arch_uprobe {
@@ -45,6 +50,8 @@ struct arch_uprobe {
 			u8	ilen;
 		}			push;
 	};
+
+	unsigned long flags;
 };
=20
 struct arch_uprobe_task {
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index d18e1ae..209ce74 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -18,6 +18,7 @@
 #include <asm/processor.h>
 #include <asm/insn.h>
 #include <asm/mmu_context.h>
+#include <asm/nops.h>
=20
 /* Post-execution fixups. */
=20
@@ -702,7 +703,6 @@ static struct uprobe_trampoline *create_uprobe_trampoline=
(unsigned long vaddr)
 	return tramp;
 }
=20
-__maybe_unused
 static struct uprobe_trampoline *get_uprobe_trampoline(unsigned long vaddr, =
bool *new)
 {
 	struct uprobes_state *state =3D &current->mm->uprobes_state;
@@ -891,6 +891,280 @@ static int __init arch_uprobes_init(void)
=20
 late_initcall(arch_uprobes_init);
=20
+enum {
+	EXPECT_SWBP,
+	EXPECT_CALL,
+};
+
+struct write_opcode_ctx {
+	unsigned long base;
+	int expect;
+};
+
+static int is_call_insn(uprobe_opcode_t *insn)
+{
+	return *insn =3D=3D CALL_INSN_OPCODE;
+}
+
+/*
+ * Verification callback used by int3_update uprobe_write calls to make sure
+ * the underlying instruction is as expected - either int3 or call.
+ */
+static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode=
_t *new_opcode,
+		       int nbytes, void *data)
+{
+	struct write_opcode_ctx *ctx =3D data;
+	uprobe_opcode_t old_opcode[5];
+
+	uprobe_copy_from_page(page, ctx->base, (uprobe_opcode_t *) &old_opcode, 5);
+
+	switch (ctx->expect) {
+	case EXPECT_SWBP:
+		if (is_swbp_insn(&old_opcode[0]))
+			return 1;
+		break;
+	case EXPECT_CALL:
+		if (is_call_insn(&old_opcode[0]))
+			return 1;
+		break;
+	}
+
+	return -1;
+}
+
+/*
+ * Modify multi-byte instructions by using INT3 breakpoints on SMP.
+ * We completely avoid using stop_machine() here, and achieve the
+ * synchronization using INT3 breakpoints and SMP cross-calls.
+ * (borrowed comment from smp_text_poke_batch_finish)
+ *
+ * The way it is done:
+ *   - Add an INT3 trap to the address that will be patched
+ *   - SMP sync all CPUs
+ *   - Update all but the first byte of the patched range
+ *   - SMP sync all CPUs
+ *   - Replace the first byte (INT3) by the first byte of the replacing opco=
de
+ *   - SMP sync all CPUs
+ */
+static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *v=
ma,
+		       unsigned long vaddr, char *insn, bool optimize)
+{
+	uprobe_opcode_t int3 =3D UPROBE_SWBP_INSN;
+	struct write_opcode_ctx ctx =3D {
+		.base =3D vaddr,
+	};
+	int err;
+
+	/*
+	 * Write int3 trap.
+	 *
+	 * The swbp_optimize path comes with breakpoint already installed,
+	 * so we can skip this step for optimize =3D=3D true.
+	 */
+	if (!optimize) {
+		ctx.expect =3D EXPECT_CALL;
+		err =3D uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
+				   true /* is_register */, false /* do_update_ref_ctr */,
+				   &ctx);
+		if (err)
+			return err;
+	}
+
+	smp_text_poke_sync_each_cpu();
+
+	/* Write all but the first byte of the patched range. */
+	ctx.expect =3D EXPECT_SWBP;
+	err =3D uprobe_write(auprobe, vma, vaddr + 1, insn + 1, 4, verify_insn,
+			   true /* is_register */, false /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+
+	/*
+	 * Write first byte.
+	 *
+	 * The swbp_unoptimize needs to finish uprobe removal together
+	 * with ref_ctr update, using uprobe_write with proper flags.
+	 */
+	err =3D uprobe_write(auprobe, vma, vaddr, insn, 1, verify_insn,
+			   optimize /* is_register */, !optimize /* do_update_ref_ctr */,
+			   &ctx);
+	if (err)
+		return err;
+
+	smp_text_poke_sync_each_cpu();
+	return 0;
+}
+
+static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct =
*vma,
+			 unsigned long vaddr, unsigned long tramp)
+{
+	u8 call[5];
+
+	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
+			(const void *) tramp, CALL_INSN_SIZE);
+	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
+}
+
+static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struc=
t *vma,
+			   unsigned long vaddr)
+{
+	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */=
);
+}
+
+static int copy_from_vaddr(struct mm_struct *mm, unsigned long vaddr, void *=
dst, int len)
+{
+	unsigned int gup_flags =3D FOLL_FORCE|FOLL_SPLIT_PMD;
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	page =3D get_user_page_vma_remote(mm, vaddr, gup_flags, &vma);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	uprobe_copy_from_page(page, vaddr, dst, len);
+	put_page(page);
+	return 0;
+}
+
+static bool __is_optimized(uprobe_opcode_t *insn, unsigned long vaddr)
+{
+	struct __packed __arch_relative_insn {
+		u8 op;
+		s32 raddr;
+	} *call =3D (struct __arch_relative_insn *) insn;
+
+	if (!is_call_insn(insn))
+		return false;
+	return __in_uprobe_trampoline(vaddr + 5 + call->raddr);
+}
+
+static int is_optimized(struct mm_struct *mm, unsigned long vaddr, bool *opt=
imized)
+{
+	uprobe_opcode_t insn[5];
+	int err;
+
+	err =3D copy_from_vaddr(mm, vaddr, &insn, 5);
+	if (err)
+		return err;
+	*optimized =3D __is_optimized((uprobe_opcode_t *)&insn, vaddr);
+	return 0;
+}
+
+static bool should_optimize(struct arch_uprobe *auprobe)
+{
+	return !test_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags) &&
+		test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+}
+
+int set_swbp(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+	     unsigned long vaddr)
+{
+	if (should_optimize(auprobe)) {
+		bool optimized =3D false;
+		int err;
+
+		/*
+		 * We could race with another thread that already optimized the probe,
+		 * so let's not overwrite it with int3 again in this case.
+		 */
+		err =3D is_optimized(vma->vm_mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized)
+			return 0;
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, UPROBE_SWBP_INSN,
+				   true /* is_register */);
+}
+
+int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
+		  unsigned long vaddr)
+{
+	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
+		struct mm_struct *mm =3D vma->vm_mm;
+		bool optimized =3D false;
+		int err;
+
+		err =3D is_optimized(mm, vaddr, &optimized);
+		if (err)
+			return err;
+		if (optimized) {
+			err =3D swbp_unoptimize(auprobe, vma, vaddr);
+			WARN_ON_ONCE(err);
+			return err;
+		}
+	}
+	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprob=
e->insn,
+				   false /* is_register */);
+}
+
+static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_str=
uct *mm,
+				  unsigned long vaddr)
+{
+	struct uprobe_trampoline *tramp;
+	struct vm_area_struct *vma;
+	bool new =3D false;
+	int err =3D 0;
+
+	vma =3D find_vma(mm, vaddr);
+	if (!vma)
+		return -EINVAL;
+	tramp =3D get_uprobe_trampoline(vaddr, &new);
+	if (!tramp)
+		return -EINVAL;
+	err =3D swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
+	if (WARN_ON_ONCE(err) && new)
+		destroy_uprobe_trampoline(tramp);
+	return err;
+}
+
+void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	struct mm_struct *mm =3D current->mm;
+	uprobe_opcode_t insn[5];
+
+	/*
+	 * Do not optimize if shadow stack is enabled, the return address hijack
+	 * code in arch_uretprobe_hijack_return_addr updates wrong frame when
+	 * the entry uprobe is optimized and the shadow stack crashes the app.
+	 */
+	if (shstk_is_enabled())
+		return;
+
+	if (!should_optimize(auprobe))
+		return;
+
+	mmap_write_lock(mm);
+
+	/*
+	 * Check if some other thread already optimized the uprobe for us,
+	 * if it's the case just go away silently.
+	 */
+	if (copy_from_vaddr(mm, vaddr, &insn, 5))
+		goto unlock;
+	if (!is_swbp_insn((uprobe_opcode_t*) &insn))
+		goto unlock;
+
+	/*
+	 * If we fail to optimize the uprobe we set the fail bit so the
+	 * above should_optimize will fail from now on.
+	 */
+	if (__arch_uprobe_optimize(auprobe, mm, vaddr))
+		set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_FAIL, &auprobe->flags);
+
+unlock:
+	mmap_write_unlock(mm);
+}
+
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	if (memcmp(&auprobe->insn, x86_nops[5], 5))
+		return false;
+	/* We can't do cross page atomic writes yet. */
+	return PAGE_SIZE - (vaddr & ~PAGE_MASK) >=3D 5;
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -904,6 +1178,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe,=
 struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *reg=
s)
 {
 }
+static bool can_optimize(struct arch_uprobe *auprobe, unsigned long vaddr)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
=20
 struct uprobe_xol_ops {
@@ -1270,6 +1548,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprob=
e, struct mm_struct *mm,=20
 	if (ret)
 		return ret;
=20
+	if (can_optimize(auprobe, addr))
+		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+
 	ret =3D branch_setup_xol_ops(auprobe, &insn);
 	if (ret !=3D -ENOSYS)
 		return ret;
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index b6b077c..08ef784 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -192,7 +192,7 @@ struct uprobes_state {
 };
=20
 typedef int (*uprobe_write_verify_t)(struct page *page, unsigned long vaddr,
-				     uprobe_opcode_t *insn, int nbytes);
+				     uprobe_opcode_t *insn, int nbytes, void *data);
=20
 extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct vm_area_struct *vma, uns=
igned long vaddr);
@@ -204,7 +204,8 @@ extern unsigned long uprobe_get_trap_addr(struct pt_regs =
*regs);
 extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_s=
truct *vma, unsigned long vaddr, uprobe_opcode_t,
 			       bool is_register);
 extern int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *=
vma, const unsigned long opcode_vaddr,
-			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_=
register, bool do_update_ref_ctr);
+			uprobe_opcode_t *insn, int nbytes, uprobe_write_verify_t verify, bool is_=
register, bool do_update_ref_ctr,
+			void *data);
 extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, lo=
ff_t ref_ctr_offset, struct uprobe_consumer *uc);
 extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, b=
ool);
 extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_co=
nsumer *uc);
@@ -240,6 +241,7 @@ extern void uprobe_copy_from_page(struct page *page, unsi=
gned long vaddr, void *
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vad=
dr);
+extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long =
vaddr);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index eb07e60..4a194d7 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -192,7 +192,7 @@ static void copy_to_page(struct page *page, unsigned long=
 vaddr, const void *src
 }
=20
 static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opco=
de_t *insn,
-			 int nbytes)
+			 int nbytes, void *data)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -491,12 +491,13 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, st=
ruct vm_area_struct *vma,
 		bool is_register)
 {
 	return uprobe_write(auprobe, vma, opcode_vaddr, &opcode, UPROBE_SWBP_INSN_S=
IZE,
-			    verify_opcode, is_register, true /* do_update_ref_ctr */);
+			    verify_opcode, is_register, true /* do_update_ref_ctr */, NULL);
 }
=20
 int uprobe_write(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 const unsigned long insn_vaddr, uprobe_opcode_t *insn, int nbytes,
-		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr)
+		 uprobe_write_verify_t verify, bool is_register, bool do_update_ref_ctr,
+		 void *data)
 {
 	const unsigned long vaddr =3D insn_vaddr & PAGE_MASK;
 	struct mm_struct *mm =3D vma->vm_mm;
@@ -530,7 +531,7 @@ retry:
 		goto out;
 	folio =3D page_folio(page);
=20
-	ret =3D verify(page, insn_vaddr, insn, nbytes);
+	ret =3D verify(page, insn_vaddr, insn, nbytes, data);
 	if (ret <=3D 0) {
 		folio_put(folio);
 		goto out;
@@ -2696,6 +2697,10 @@ bool __weak arch_uretprobe_is_alive(struct return_inst=
ance *ret, enum rp_check c
 	return true;
 }
=20
+void __weak arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long =
vaddr)
+{
+}
+
 /*
  * Run handler and ask thread to singlestep.
  * Ensure all non-fatal signals cannot interrupt thread while it singlesteps.
@@ -2760,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
=20
 	handler_chain(uprobe, regs);
=20
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
=20

