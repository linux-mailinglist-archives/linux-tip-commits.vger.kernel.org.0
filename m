Return-Path: <linux-tip-commits+bounces-7746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E635CC7B3F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61773049C94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036234847E;
	Wed, 17 Dec 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YS31D9NM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5SSgL0PN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF4346FA7;
	Wed, 17 Dec 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975095; cv=none; b=VPxE2tkl//qBr7/KZJUn5iYH1yz0zyK87q69KjfkK1xFacGsFXpiElRt08l+sw1z0kc8ohAutRVCk+cbigG5ua4HmkJ+Tm/dZWbr6L7/COA/TedUnSN5FVVPWvFoen55ywWmFrOz5OuUFXhwQEDgNm5uWlgbezpipHj9InGBeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975095; c=relaxed/simple;
	bh=Sy+9k08VH+0lrY3dq9dwIOJMuc6KhzQ2O8RqLy467xo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrjpqXAOydmfdrLibloG9Chl118eKjhay3vUCbDSK5QFq8ojY7z1PrLPIWsOJ51TApb6fVahHWyjtDXfEujA6fu4gUUHybWxAXV3xySXE/oahousvtuE7sU5CQkGBozNak7NklLV9dF22UsI4S4kgJnBvW5DzN+84IQghVqxVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YS31D9NM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5SSgL0PN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4+xqHL+QJjz0TliKaks6MM50X6hl8/rrk+GXxlw6uE=;
	b=YS31D9NMY/UCocblOoqo0UHJf2h3qR7/IampiWFmHAaKyiqKTjb+nz+yWN5oIAOfyOhmNL
	ODpFcK/YioXg2YLFzSH1z0+yxTx+2f56l+UhTHg9Su1V50+fwJ4rn7JTPWYFFAAEpxgGQ3
	iBPOktnz137IV0L5F/skVALu6p8t8x0HRDHjUcDUK+rlJSJhgxyI96w4xfEO5IjYsWua8r
	hvs+AMDrLK2leAVeHW+o51dqYfUPZJjDGBL40OxdilBG1Dcc1cyaLSe6mu+TqYGj3Tizhb
	aXzuiHCYU5j9skihU7hBucfyhxZBT5AWGKtvU/l/uToO7e6pTxE6VUZYYykgjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4+xqHL+QJjz0TliKaks6MM50X6hl8/rrk+GXxlw6uE=;
	b=5SSgL0PNOVMEOMS0+pbvumxZ5mWe22CulXqT/U/U5e0sV05jivUC4gi58nC8IdfI6eT6Qw
	msBJObK0PdaaRmAA==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/core: Register a new vector for handling
 mediated guest PMIs
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-9-seanjc@google.com>
References: <20251206001720.468579-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509146.510.4585367412750912510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a05385d84b2af64600fc84b027bea481e8f6261d
Gitweb:        https://git.kernel.org/tip/a05385d84b2af64600fc84b027bea481e8f=
6261d
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:44 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:05 +01:00

perf/x86/core: Register a new vector for handling mediated guest PMIs

Wire up system vector 0xf5 for handling PMIs (i.e. interrupts delivered
through the LVTPC) while running KVM guests with a mediated PMU.  Perf
currently delivers all PMIs as NMIs, e.g. so that events that trigger while
IRQs are disabled aren't delayed and generate useless records, but due to
the multiplexing of NMIs throughout the system, correctly identifying NMIs
for a mediated PMU is practically infeasible.

To (greatly) simplify identifying guest mediated PMU PMIs, perf will
switch the CPU's LVTPC between PERF_GUEST_MEDIATED_PMI_VECTOR and NMI when
guest PMU context is loaded/put.  I.e. PMIs that are generated by the CPU
while the guest is active will be identified purely based on the IRQ
vector.

Route the vector through perf, e.g. as opposed to letting KVM attach a
handler directly a la posted interrupt notification vectors, as perf owns
the LVTPC and thus is the rightful owner of PERF_GUEST_MEDIATED_PMI_VECTOR.
Functionally, having KVM directly own the vector would be fine (both KVM
and perf will be completely aware of when a mediated PMU is active), but
would lead to an undesirable split in ownership: perf would be responsible
for installing the vector, but not handling the resulting IRQs.

Add a new perf_guest_info_callbacks hook (and static call) to allow KVM to
register its handler with perf when running guests with mediated PMUs.

Note, because KVM always runs guests with host IRQs enabled, there is no
danger of a PMI being delayed from the guest's perspective due to using a
regular IRQ instead of an NMI.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-9-seanjc@google.com
---
 arch/x86/entry/entry_fred.c                                |  1 +-
 arch/x86/include/asm/hardirq.h                             |  3 +-
 arch/x86/include/asm/idtentry.h                            |  6 ++-
 arch/x86/include/asm/irq_vectors.h                         |  4 +-
 arch/x86/kernel/idt.c                                      |  3 +-
 arch/x86/kernel/irq.c                                      | 19 +++++++-
 include/linux/perf_event.h                                 |  8 +++-
 kernel/events/core.c                                       |  9 ++-
 tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h |  3 +-
 virt/kvm/kvm_main.c                                        |  3 +-
 10 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 94e626c..a9b7299 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -114,6 +114,7 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_af=
ter_init =3D {
=20
 	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
=20
+	SYSVEC(PERF_GUEST_MEDIATED_PMI_VECTOR,	perf_guest_mediated_pmi_handler),
 	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
 	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 6b6d472..9314642 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -19,6 +19,9 @@ typedef struct {
 	unsigned int kvm_posted_intr_wakeup_ipis;
 	unsigned int kvm_posted_intr_nested_ipis;
 #endif
+#ifdef CONFIG_GUEST_PERF_EVENTS
+	unsigned int perf_guest_mediated_pmis;
+#endif
 	unsigned int x86_platform_ipis;	/* arch dependent */
 	unsigned int apic_perf_irqs;
 	unsigned int apic_irq_work_irqs;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3218770..42bf6a5 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -746,6 +746,12 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysve=
c_kvm_posted_intr_nested
 # define fred_sysvec_kvm_posted_intr_nested_ipi		NULL
 #endif
=20
+# ifdef CONFIG_GUEST_PERF_EVENTS
+DECLARE_IDTENTRY_SYSVEC(PERF_GUEST_MEDIATED_PMI_VECTOR,	sysvec_perf_guest_me=
diated_pmi_handler);
+#else
+# define fred_sysvec_perf_guest_mediated_pmi_handler	NULL
+#endif
+
 # ifdef CONFIG_X86_POSTED_MSI
 DECLARE_IDTENTRY_SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	sysvec_posted_msi_no=
tification);
 #else
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_ve=
ctors.h
index 4705187..85253fc 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -77,7 +77,9 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
=20
-/* 0xf5 - unused, was UV_BAU_MESSAGE */
+/* IRQ vector for PMIs when running a guest with a mediated PMU. */
+#define PERF_GUEST_MEDIATED_PMI_VECTOR	0xf5
+
 #define DEFERRED_ERROR_VECTOR		0xf4
=20
 /* Vector on which hypervisor callbacks will be delivered */
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index f445bec..2604565 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -158,6 +158,9 @@ static const __initconst struct idt_data apic_idts[] =3D {
 	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
 	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
 # endif
+#ifdef CONFIG_GUEST_PERF_EVENTS
+	INTG(PERF_GUEST_MEDIATED_PMI_VECTOR,	asm_sysvec_perf_guest_mediated_pmi_han=
dler),
+#endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
 # endif
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 86f4e57..d56185b 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -192,6 +192,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
 #endif
+#ifdef CONFIG_GUEST_PERF_EVENTS
+	seq_printf(p, "%*s: ", prec, "VPMI");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->perf_guest_mediated_pmis);
+	seq_puts(p, " Perf Guest Mediated PMI\n");
+#endif
 #ifdef CONFIG_X86_POSTED_MSI
 	seq_printf(p, "%*s: ", prec, "PMN");
 	for_each_online_cpu(j)
@@ -349,6 +356,18 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 }
 #endif
=20
+#ifdef CONFIG_GUEST_PERF_EVENTS
+/*
+ * Handler for PERF_GUEST_MEDIATED_PMI_VECTOR.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_perf_guest_mediated_pmi_handler)
+{
+	 apic_eoi();
+	 inc_irq_stat(perf_guest_mediated_pmis);
+	 perf_guest_handle_mediated_pmi();
+}
+#endif
+
 #if IS_ENABLED(CONFIG_KVM)
 static void dummy_handler(void) {}
 static void (*kvm_posted_intr_wakeup_handler)(void) =3D dummy_handler;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 322cfa9..82e617f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1677,6 +1677,8 @@ struct perf_guest_info_callbacks {
 	unsigned int			(*state)(void);
 	unsigned long			(*get_ip)(void);
 	unsigned int			(*handle_intel_pt_intr)(void);
+
+	void				(*handle_mediated_pmi)(void);
 };
=20
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -1686,6 +1688,7 @@ extern struct perf_guest_info_callbacks __rcu *perf_gue=
st_cbs;
 DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
 DECLARE_STATIC_CALL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->hand=
le_intel_pt_intr);
+DECLARE_STATIC_CALL(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->handl=
e_mediated_pmi);
=20
 static inline unsigned int perf_guest_state(void)
 {
@@ -1702,6 +1705,11 @@ static inline unsigned int perf_guest_handle_intel_pt_=
intr(void)
 	return static_call(__perf_guest_handle_intel_pt_intr)();
 }
=20
+static inline void perf_guest_handle_mediated_pmi(void)
+{
+	static_call(__perf_guest_handle_mediated_pmi)();
+}
+
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callba=
cks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_call=
backs *cbs);
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bbb81a4..dd842a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7644,6 +7644,7 @@ struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
 DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
 DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->=
handle_intel_pt_intr);
+DEFINE_STATIC_CALL_RET0(__perf_guest_handle_mediated_pmi, *perf_guest_cbs->h=
andle_mediated_pmi);
=20
 void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cb=
s)
 {
@@ -7658,6 +7659,10 @@ void perf_register_guest_info_callbacks(struct perf_gu=
est_info_callbacks *cbs)
 	if (cbs->handle_intel_pt_intr)
 		static_call_update(__perf_guest_handle_intel_pt_intr,
 				   cbs->handle_intel_pt_intr);
+
+	if (cbs->handle_mediated_pmi)
+		static_call_update(__perf_guest_handle_mediated_pmi,
+				   cbs->handle_mediated_pmi);
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
=20
@@ -7669,8 +7674,8 @@ void perf_unregister_guest_info_callbacks(struct perf_g=
uest_info_callbacks *cbs)
 	rcu_assign_pointer(perf_guest_cbs, NULL);
 	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
 	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
-	static_call_update(__perf_guest_handle_intel_pt_intr,
-			   (void *)&__static_call_return0);
+	static_call_update(__perf_guest_handle_intel_pt_intr, (void *)&__static_cal=
l_return0);
+	static_call_update(__perf_guest_handle_mediated_pmi, (void *)&__static_call=
_return0);
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
diff --git a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h b/too=
ls/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
index 4705187..6e1d5b9 100644
--- a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
+++ b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
@@ -77,7 +77,8 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
=20
-/* 0xf5 - unused, was UV_BAU_MESSAGE */
+#define PERF_GUEST_MEDIATED_PMI_VECTOR	0xf5
+
 #define DEFERRED_ERROR_VECTOR		0xf4
=20
 /* Vector on which hypervisor callbacks will be delivered */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5fcd401..21a0d22 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6467,11 +6467,14 @@ static struct perf_guest_info_callbacks kvm_guest_cbs=
 =3D {
 	.state			=3D kvm_guest_state,
 	.get_ip			=3D kvm_guest_get_ip,
 	.handle_intel_pt_intr	=3D NULL,
+	.handle_mediated_pmi	=3D NULL,
 };
=20
 void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void))
 {
 	kvm_guest_cbs.handle_intel_pt_intr =3D pt_intr_handler;
+	kvm_guest_cbs.handle_mediated_pmi =3D NULL;
+
 	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
 void kvm_unregister_perf_callbacks(void)

