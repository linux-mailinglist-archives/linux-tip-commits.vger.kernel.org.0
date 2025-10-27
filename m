Return-Path: <linux-tip-commits+bounces-7009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37EC0F506
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAB804E837E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3F3164A5;
	Mon, 27 Oct 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dyMUPSIT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIV+ia8D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FC315D37;
	Mon, 27 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582665; cv=none; b=o/+oJFfqfoHZnpXbyIe5CdUCdja5lunvrKcCyCJYmTrBNA3r5dr7RdLy4eq2EyacKuNtp61Fc5WnLlrWLhg8yqCEd0Zm3cjdGZ27h+R3G4DhoSQ7oOIkDZ6a0BeQIfjQExC8HXfj5K7bTK6GL/OMh8LPvSQ0uU7RE22rlm7SiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582665; c=relaxed/simple;
	bh=HhPu1J0pY5QR6YJ6m55I3vRboxuKHc+YHYaXWZ++8qk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PLPNYoHB9Fz38a1OAKZcOVNdyRRUVUcnQTN90IYI1Uoa1j/tNtxhsz1hWr1Cq5WUeE/4DKNd35z6/RaHREHimG8VDE/ybkk1nVJbULAJEcfXbYlx7NWCbApT/I9s0ErppJnuJDiQ4zYivuDf8A6a4H1O44AQihbNZZwZo+RluWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dyMUPSIT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIV+ia8D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKIYO2hzLg2gmop+gpi0+Xjrb/OuHX8BZFIqNHM2wWQ=;
	b=dyMUPSIT/SqAZ8YWMKbbPjw0hGYX8hYUq9D8KJRh1HtYWlOCnnbV00gRizS8T1eAleVQ8g
	D2aAI4XkLf6rvy6v0KrlKuFsN+/vue+ASAH0O1fBwij/Qd6q/dstnT5Bw57sgd0NTPtfoh
	iTGuN8/FdcHT747HQZgOAl01Ff8L9CgzKivcuNty9ZLXeZZ2AQ1weW+yAmTtWuViEBk2u5
	l8BQQo9b5WZnK1Lb2josU700KZCVaE9YRqyGoSstm7+OGVHHk73v+0T6jUtouWNGUVAFBc
	MAV97V6wb8I83ZlN20BuR8JCwoPcFfzXFsLu48gzdivlLNyj3XJ+OPX7FIg9qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKIYO2hzLg2gmop+gpi0+Xjrb/OuHX8BZFIqNHM2wWQ=;
	b=aIV+ia8D41SXv3fsDUt6kn+z/knAKazMLkEKtwW30dh/MC+Gt5IF9b3Ao3PVeUexme5IQg
	YFQmxBEvSmXfndBA==
From: "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] perf: arm_pmu: Request specific affinities for per
 CPU NMIs/interrupts
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-19-maz@kernel.org>
References: <20251020122944.3074811-19-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266119.2601451.64470048617873534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     54b350fa8e965dc59622698e2a18d6bf73944bf4
Gitweb:        https://git.kernel.org/tip/54b350fa8e965dc59622698e2a18d6bf739=
44bf4
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:35 +01:00

perf: arm_pmu: Request specific affinities for per CPU NMIs/interrupts

Let the PMU driver request both NMIs and normal interrupts with an affinity m=
ask
matching the PMU affinity.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-19-maz@kernel.org
---
 drivers/perf/arm_pmu.c          | 44 ++++++++++++++++++--------------
 drivers/perf/arm_pmu_acpi.c     |  2 +-
 drivers/perf/arm_pmu_platform.c |  4 +--
 include/linux/perf/arm_pmu.h    |  4 +--
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 22c601b..959ceb3 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,7 +26,8 @@
=20
 #include <asm/irq_regs.h>
=20
-static int armpmu_count_irq_users(const int irq);
+static int armpmu_count_irq_users(const struct cpumask *affinity,
+				  const int irq);
=20
 struct pmu_irq_ops {
 	void (*enable_pmuirq)(unsigned int irq);
@@ -64,7 +65,9 @@ static void armpmu_enable_percpu_pmuirq(unsigned int irq)
 static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
 				   void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) =3D=3D 1)
+	struct arm_pmu *armpmu =3D *per_cpu_ptr((void * __percpu *)devid, cpu);
+
+	if (armpmu_count_irq_users(&armpmu->supported_cpus, irq) =3D=3D 1)
 		free_percpu_irq(irq, devid);
 }
=20
@@ -89,7 +92,9 @@ static void armpmu_disable_percpu_pmunmi(unsigned int irq)
 static void armpmu_free_percpu_pmunmi(unsigned int irq, int cpu,
 				      void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) =3D=3D 1)
+	struct arm_pmu *armpmu =3D *per_cpu_ptr((void * __percpu *)devid, cpu);
+
+	if (armpmu_count_irq_users(&armpmu->supported_cpus, irq) =3D=3D 1)
 		free_percpu_nmi(irq, devid);
 }
=20
@@ -580,11 +585,11 @@ static const struct attribute_group armpmu_common_attr_=
group =3D {
 	.attrs =3D armpmu_common_attrs,
 };
=20
-static int armpmu_count_irq_users(const int irq)
+static int armpmu_count_irq_users(const struct cpumask *affinity, const int =
irq)
 {
 	int cpu, count =3D 0;
=20
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) =3D=3D irq)
 			count++;
 	}
@@ -592,12 +597,13 @@ static int armpmu_count_irq_users(const int irq)
 	return count;
 }
=20
-static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
+static const struct pmu_irq_ops *
+armpmu_find_irq_ops(const struct cpumask *affinity, int irq)
 {
 	const struct pmu_irq_ops *ops =3D NULL;
 	int cpu;
=20
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) !=3D irq)
 			continue;
=20
@@ -609,22 +615,25 @@ static const struct pmu_irq_ops *armpmu_find_irq_ops(in=
t irq)
 	return ops;
 }
=20
-void armpmu_free_irq(int irq, int cpu)
+void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu)
 {
 	if (per_cpu(cpu_irq, cpu) =3D=3D 0)
 		return;
 	if (WARN_ON(irq !=3D per_cpu(cpu_irq, cpu)))
 		return;
=20
-	per_cpu(cpu_irq_ops, cpu)->free_pmuirq(irq, cpu, &cpu_armpmu);
+	per_cpu(cpu_irq_ops, cpu)->free_pmuirq(irq, cpu, armpmu);
=20
 	per_cpu(cpu_irq, cpu) =3D 0;
 	per_cpu(cpu_irq_ops, cpu) =3D NULL;
 }
=20
-int armpmu_request_irq(int irq, int cpu)
+int armpmu_request_irq(struct arm_pmu * __percpu *pcpu_armpmu, int irq, int =
cpu)
 {
 	int err =3D 0;
+	struct arm_pmu **armpmu =3D per_cpu_ptr(pcpu_armpmu, cpu);
+	const struct cpumask *affinity =3D *armpmu ? &(*armpmu)->supported_cpus :
+						   cpu_possible_mask; /* ACPI */
 	const irq_handler_t handler =3D armpmu_dispatch_irq;
 	const struct pmu_irq_ops *irq_ops;
=20
@@ -646,25 +655,24 @@ int armpmu_request_irq(int irq, int cpu)
 			    IRQF_NOBALANCING | IRQF_NO_AUTOEN |
 			    IRQF_NO_THREAD;
=20
-		err =3D request_nmi(irq, handler, irq_flags, "arm-pmu",
-				  per_cpu_ptr(&cpu_armpmu, cpu));
+		err =3D request_nmi(irq, handler, irq_flags, "arm-pmu", armpmu);
=20
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
 			err =3D request_irq(irq, handler, irq_flags, "arm-pmu",
-					  per_cpu_ptr(&cpu_armpmu, cpu));
+					  armpmu);
 			irq_ops =3D &pmuirq_ops;
 		} else {
 			has_nmi =3D true;
 			irq_ops =3D &pmunmi_ops;
 		}
-	} else if (armpmu_count_irq_users(irq) =3D=3D 0) {
-		err =3D request_percpu_nmi(irq, handler, "arm-pmu", NULL, &cpu_armpmu);
+	} else if (armpmu_count_irq_users(affinity, irq) =3D=3D 0) {
+		err =3D request_percpu_nmi(irq, handler, "arm-pmu", affinity, pcpu_armpmu);
=20
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
-			err =3D request_percpu_irq(irq, handler, "arm-pmu",
-						 &cpu_armpmu);
+			err =3D request_percpu_irq_affinity(irq, handler, "arm-pmu",
+							  affinity, pcpu_armpmu);
 			irq_ops =3D &percpu_pmuirq_ops;
 		} else {
 			has_nmi =3D true;
@@ -672,7 +680,7 @@ int armpmu_request_irq(int irq, int cpu)
 		}
 	} else {
 		/* Per cpudevid irq was already requested by another CPU */
-		irq_ops =3D armpmu_find_irq_ops(irq);
+		irq_ops =3D armpmu_find_irq_ops(affinity, irq);
=20
 		if (WARN_ON(!irq_ops))
 			err =3D -EINVAL;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 05dda19..e80f76d 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -218,7 +218,7 @@ static int arm_pmu_acpi_parse_irqs(void)
 		 * them with their PMUs.
 		 */
 		per_cpu(pmu_irqs, cpu) =3D irq;
-		err =3D armpmu_request_irq(irq, cpu);
+		err =3D armpmu_request_irq(&probed_pmus, irq, cpu);
 		if (err)
 			goto out_err;
 	}
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 9c0494d..1c9e50a 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -165,7 +165,7 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
 		if (!irq)
 			continue;
=20
-		err =3D armpmu_request_irq(irq, cpu);
+		err =3D armpmu_request_irq(&hw_events->percpu_pmu, irq, cpu);
 		if (err)
 			break;
 	}
@@ -181,7 +181,7 @@ static void armpmu_free_irqs(struct arm_pmu *armpmu)
 	for_each_cpu(cpu, &armpmu->supported_cpus) {
 		int irq =3D per_cpu(hw_events->irq, cpu);
=20
-		armpmu_free_irq(irq, cpu);
+		armpmu_free_irq(&hw_events->percpu_pmu, irq, cpu);
 	}
 }
=20
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 93c9a26..6690bd7 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -190,8 +190,8 @@ bool arm_pmu_irq_is_nmi(void);
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
-int armpmu_request_irq(int irq, int cpu);
-void armpmu_free_irq(int irq, int cpu);
+int armpmu_request_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
+void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
=20
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
=20

