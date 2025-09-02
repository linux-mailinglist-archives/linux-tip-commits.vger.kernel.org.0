Return-Path: <linux-tip-commits+bounces-6413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00BB3FCC8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B2418891FF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB22FA0E2;
	Tue,  2 Sep 2025 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wsp2I1Bs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hkR1yOyx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7F2F3C36;
	Tue,  2 Sep 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809411; cv=none; b=I8R0ZKH+EPz2B/2qIDdYz7vzNR3TWGj9JHHTU/RdjJoDdykxsyItzKpgr81lWwzPe5CF1f50z1js/WCa4Gx/HnHn/vaNzraDHO9/B6qvzxSEQ0EPxoHt/VQFo7bl0KFC989RW3NRE0zhaOd6ILh9KWtyEAo1UUHagvPAI5jOc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809411; c=relaxed/simple;
	bh=44ZBvI8L+H9o1ylD46UzGL1Z6JU1ygPRj0U8yn0dEEk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rfGhLFPASH9kLIqZZwy2OjFhX9BLYGcAAz+J1ZxHQlSy+BgDcpwZX3vD5YZp0dgE3TAYLa56ivfY8OBCierVshal4n3GBiwLIwCCQMc23hiWzst2mOoFlzhYaI7WI+IRMMmNyzEaaBoJHrEkOBLYUC1hWQXNshJHr7C7vDGYH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wsp2I1Bs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hkR1yOyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUJv32CQppQyXYR967UvQXruWh2EEsg2z5Byy0vtqps=;
	b=wsp2I1BseGBB4/d0yqIcQyI15I2vTEGjGM9Cxjh6zAI/3jOLSs7ouyeLmrcDrYSXA2N78E
	SyFvZ1q57GPhgdVmqBxtt4DOHXOmcF6iF81bZGwbB5o4ucdv7+d2qjKOkAwLTDvCC7I7ug
	+8lF9N0py53HSwIfFt2cDKOi+yus66U1BR8r5Ll/vvTq9NVcGaEteOQk8k7GWc3g4vthbt
	g35uFNXPHFl+ta2PODcqEB5DTjeacsDF5cDvtzn7lv6WAmWTkx5QXYlK/ayBB/6CdVMQkY
	0RrmqVK0u1/3poOUGIvcsQLyYqEAiAHtzauUmWKIISfa0zIPefrxHzSACEQ9zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809407;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUJv32CQppQyXYR967UvQXruWh2EEsg2z5Byy0vtqps=;
	b=hkR1yOyxnbv5Jr8iQZqthjOr+6zKGNXNxsRQGaORrrF0DvQXT7V/5pXh8zM9Bd3/zAoSKz
	nWAG6ciIx9IcbDAA==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/apic: Add update_vector() callback for APIC drivers
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828110255.208779-3-Neeraj.Upadhyay@amd.com>
References: <20250828110255.208779-3-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940659.1920.16213813283457791362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     60791ef3751cb0ceccd6f5ac98276153745c7980
Gitweb:        https://git.kernel.org/tip/60791ef3751cb0ceccd6f5ac98276153745=
c7980
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:32:42 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:36:46 +02:00

x86/apic: Add update_vector() callback for APIC drivers

Add an update_vector() callback to allow APIC drivers to perform driver
specific operations on external vector allocation/teardown on a CPU. This
callback will be used by the Secure AVIC APIC driver to configure the vectors
which a guest vCPU allows the hypervisor to send to it.

As system vectors have fixed vector assignments and are not dynamically
allocated, add an apic_update_vector() public API to facilitate
update_vector() callback invocation for them. This will be used for Secure
AVIC enabled guests to allow the hypervisor to inject system vectors which are
emulated by the hypervisor such as APIC timer vector and
HYPERVISOR_CALLBACK_VECTOR.

While at it, cleanup line break in apic_update_irq_cfg().

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828110255.208779-3-Neeraj.Upadhyay@amd.com
---
 arch/x86/include/asm/apic.h   |  9 +++++++++
 arch/x86/kernel/apic/vector.c | 28 +++++++++++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 44b4080..0683318 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -318,6 +318,8 @@ struct apic {
 	/* wakeup secondary CPU using 64-bit wakeup point */
 	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip, unsigne=
d int cpu);
=20
+	void	(*update_vector)(unsigned int cpu, unsigned int vector, bool set);
+
 	char	*name;
 };
=20
@@ -471,6 +473,12 @@ static __always_inline bool apic_id_valid(u32 apic_id)
 	return apic_id <=3D apic->max_apic_id;
 }
=20
+static __always_inline void apic_update_vector(unsigned int cpu, unsigned in=
t vector, bool set)
+{
+	if (apic->update_vector)
+		apic->update_vector(cpu, vector, set);
+}
+
 #else /* CONFIG_X86_LOCAL_APIC */
=20
 static inline u32 apic_read(u32 reg) { return 0; }
@@ -482,6 +490,7 @@ static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
 static inline void apic_native_eoi(void) { WARN_ON_ONCE(1); }
 static inline void apic_setup_apic_calls(void) { }
+static inline void apic_update_vector(unsigned int cpu, unsigned int vector,=
 bool set) { }
=20
 #define apic_update_callback(_callback, _fn) do { } while (0)
=20
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a947b46..bddc544 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -134,13 +134,20 @@ static void apic_update_irq_cfg(struct irq_data *irqd, =
unsigned int vector,
=20
 	apicd->hw_irq_cfg.vector =3D vector;
 	apicd->hw_irq_cfg.dest_apicid =3D apic->calc_dest_apicid(cpu);
+
+	apic_update_vector(cpu, vector, true);
+
 	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
-	trace_vector_config(irqd->irq, vector, cpu,
-			    apicd->hw_irq_cfg.dest_apicid);
+	trace_vector_config(irqd->irq, vector, cpu, apicd->hw_irq_cfg.dest_apicid);
 }
=20
-static void apic_update_vector(struct irq_data *irqd, unsigned int newvec,
-			       unsigned int newcpu)
+static void apic_free_vector(unsigned int cpu, unsigned int vector, bool man=
aged)
+{
+	apic_update_vector(cpu, vector, false);
+	irq_matrix_free(vector_matrix, cpu, vector, managed);
+}
+
+static void chip_data_update(struct irq_data *irqd, unsigned int newvec, uns=
igned int newcpu)
 {
 	struct apic_chip_data *apicd =3D apic_chip_data(irqd);
 	struct irq_desc *desc =3D irq_data_to_desc(irqd);
@@ -174,8 +181,7 @@ static void apic_update_vector(struct irq_data *irqd, uns=
igned int newvec,
 		apicd->prev_cpu =3D apicd->cpu;
 		WARN_ON_ONCE(apicd->cpu =3D=3D newcpu);
 	} else {
-		irq_matrix_free(vector_matrix, apicd->cpu, apicd->vector,
-				managed);
+		apic_free_vector(apicd->cpu, apicd->vector, managed);
 	}
=20
 setnew:
@@ -261,7 +267,7 @@ assign_vector_locked(struct irq_data *irqd, const struct =
cpumask *dest)
 	trace_vector_alloc(irqd->irq, vector, resvd, vector);
 	if (vector < 0)
 		return vector;
-	apic_update_vector(irqd, vector, cpu);
+	chip_data_update(irqd, vector, cpu);
=20
 	return 0;
 }
@@ -337,7 +343,7 @@ assign_managed_vector(struct irq_data *irqd, const struct=
 cpumask *dest)
 	trace_vector_alloc_managed(irqd->irq, vector, vector);
 	if (vector < 0)
 		return vector;
-	apic_update_vector(irqd, vector, cpu);
+	chip_data_update(irqd, vector, cpu);
=20
 	return 0;
 }
@@ -357,7 +363,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 			   apicd->prev_cpu);
=20
 	per_cpu(vector_irq, apicd->cpu)[vector] =3D VECTOR_SHUTDOWN;
-	irq_matrix_free(vector_matrix, apicd->cpu, vector, managed);
+	apic_free_vector(apicd->cpu, vector, managed);
 	apicd->vector =3D 0;
=20
 	/* Clean up move in progress */
@@ -366,7 +372,7 @@ static void clear_irq_vector(struct irq_data *irqd)
 		return;
=20
 	per_cpu(vector_irq, apicd->prev_cpu)[vector] =3D VECTOR_SHUTDOWN;
-	irq_matrix_free(vector_matrix, apicd->prev_cpu, vector, managed);
+	apic_free_vector(apicd->prev_cpu, vector, managed);
 	apicd->prev_vector =3D 0;
 	apicd->move_in_progress =3D 0;
 	hlist_del_init(&apicd->clist);
@@ -905,7 +911,7 @@ static void free_moved_vector(struct apic_chip_data *apic=
d)
 	 *    affinity mask comes online.
 	 */
 	trace_vector_free_moved(apicd->irq, cpu, vector, managed);
-	irq_matrix_free(vector_matrix, cpu, vector, managed);
+	apic_free_vector(cpu, vector, managed);
 	per_cpu(vector_irq, cpu)[vector] =3D VECTOR_UNUSED;
 	hlist_del_init(&apicd->clist);
 	apicd->prev_vector =3D 0;

