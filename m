Return-Path: <linux-tip-commits+bounces-2650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABD9B667D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 15:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E21C20C3C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A21F7068;
	Wed, 30 Oct 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dSU3/mFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5zdGI+MH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B81F12FA;
	Wed, 30 Oct 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299797; cv=none; b=QCqJXlGP5q984xBw+0plYAn/xdMIJ3UMAKbMbbPD29+2Gql97fFXSEXiXW3ROK445rWgITy3bhyYcHlEAUE+wq0zGwKYyPHyQq40cBaUNWRIbwSpaxSfGvl55buB5Ka9MPFPO0TWxE0sc8BtkGhitp6TzxON1NWy3OUeCCaJTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299797; c=relaxed/simple;
	bh=3rJD0IoOHzoljRmHYCVcQ7jrw/vRQuOJiOESY5oQApY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PCF0djhp+WvwXN91D27AeMg53rEIJkG4XABt/pIPI/NreGOKKXV7Ep88G8IhJpIScx+A2kT5EofSB72y+mdSBRUQFeLNklwzgLyEYK68fi8G2ATu3GlwH7XcM6mNU4lPB38pED50hY/8A3fboFdE9C58laxXVSouyZbAqaoOPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dSU3/mFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5zdGI+MH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 14:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730299794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/DfybQb4KOdfgEHV8N9RTu3gwHbZnhqHnAcnYys8yA=;
	b=dSU3/mFC+0KiwYlriOYatBR2CHMFNxqxou1iu01doOXfAvh/Jlo4R0/yV9iPum0ehe1HRb
	xQW7+uEcSEmzaNljYKozA/SiKEQCe7CIjWRD12t4e+tdGoSYKr8hD2yIY5sqVgvVn8/ypJ
	m3hX9en26kCBdKm2k5nICcm+OHp6mP9DGAJqnWqRanHkGdzPwpnk3udh+gHfWXXZ5BE9BE
	FA6sAo1+Tw+s7UdHgkcQkkqC4+cj+YE/YnsPC6Ex3tuoN0jyWnWAm2G68/NM29y486ci1P
	3rGe4RnWUFu5Srl3iniE1XMr8OYW6ds7FVuzL6EJOj9k0u17DOiL6J256HVSng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730299794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/DfybQb4KOdfgEHV8N9RTu3gwHbZnhqHnAcnYys8yA=;
	b=5zdGI+MHscp7v4HcWdbf78VNsK9WTl8b5nKzVeGBCPolfp+5NPWbPI9ay49T8d23Itl0pj
	kCesBM+lCYaDwNAw==
From: "tip-bot2 for Paul Burton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mips-gic: Support multi-cluster in
 for_each_online_cpu_gic()
Cc: Paul Burton <paulburton@kernel.org>, "Chao-ying Fu" <cfu@wavecomp.com>,
 Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Serge Semin <fancer.lancer@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241028175935.51250-3-arikalo@gmail.com>
References: <20241028175935.51250-3-arikalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173029979323.3137.10389404869472643777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d9e2ed610a6094534d13ea347c7b7a5bd7ce4ee5
Gitweb:        https://git.kernel.org/tip/d9e2ed610a6094534d13ea347c7b7a5bd7ce4ee5
Author:        Paul Burton <paulburton@kernel.org>
AuthorDate:    Mon, 28 Oct 2024 18:59:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 15:41:18 +01:00

irqchip/mips-gic: Support multi-cluster in for_each_online_cpu_gic()

Use CM's GCR_CL_REDIRECT register to access registers in remote clusters,
so that users of gic_with_each_online_cpu() gains support for multi-cluster
without further changes.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/all/20241028175935.51250-3-arikalo@gmail.com

---
 drivers/irqchip/irq-mips-gic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 6c7a7d2..29bdfdc 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -88,6 +88,12 @@ static int __gic_with_next_online_cpu(int prev)
 	return cpu;
 }
 
+static inline void gic_unlock_cluster(void)
+{
+	if (mips_cps_multicluster_cpus())
+		mips_cm_unlock_other();
+}
+
 /**
  * for_each_online_cpu_gic() - Iterate over online CPUs, access local registers
  * @cpu: An integer variable to hold the current CPU number
@@ -102,6 +108,7 @@ static int __gic_with_next_online_cpu(int prev)
 	guard(raw_spinlock_irqsave)(gic_lock);		\
 	for ((cpu) = __gic_with_next_online_cpu(-1);	\
 	     (cpu) < nr_cpu_ids;			\
+	     gic_unlock_cluster(),			\
 	     (cpu) = __gic_with_next_online_cpu(cpu))
 
 static void gic_clear_pcpu_masks(unsigned int intr)

