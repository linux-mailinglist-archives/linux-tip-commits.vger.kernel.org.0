Return-Path: <linux-tip-commits+bounces-5432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C4BAAE11C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5676C520419
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67415289E1F;
	Wed,  7 May 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cC7FYZXb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NBgQ7zdU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A628A717;
	Wed,  7 May 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625457; cv=none; b=fAqiVP+kp7c/uK+zYXdPo8oBNx7mOV0O/z0pj8CAEIY66IVHEIxXVc7W4COrE8gy1GpoLZLuIfYaRffYeUZIKXF8M1Cz6ocQCQgk281yg5Jsuo97dwGUffiGC3em4bHHq2DYJIB9u/ICTl2CSaoeVcCbWF6QkZ9aMuUbX8Z1crU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625457; c=relaxed/simple;
	bh=C0TYnbqOgeTFKQK0goGLcXLb3V6eG59nBK/DW2sIdU0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wqd2KT9hgh67xS74Mpsf9vEaPbFTfhdjFtIy5TfXAo/S9ntNqb+xuwiXMj2dP83/GIV7zjfdpRWK5ufofUwqdxuMdyMIMU2wrcz7uElOmU3P5QSJcF8eTMB+PosnnQcjYRyOD2CoQUBTpHpGUvTJJU2W3pCleBCmkanSHhUgtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cC7FYZXb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NBgQ7zdU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE2kbgjGWycT+/j2EegI16cfx8bb6rrnm0Qn32IUbV0=;
	b=cC7FYZXbCsi1saUQay+LYcyviZb9eoGVluqil1eg1oiGEsSM7/lo9LILlrkVE3urOCRqXq
	mAbDnYVZ9VP0LuP2zTkNOCJoFsbE3C7+qzjyv1laGaJpfegdqbciAIp5O40uyQ03Q+dmhu
	HdcpnLhq37jqzLRJtzy56ELEVOaeJ/oxLyfiob2WZ5IjvcwsiC6XOdOztFSIli/VF068xl
	HFJopVXXvAxBPXwCep6SKYpZ5S8A+RELghvbJQYfkz67yd33QMlGks4MQgvvUnnBr6uwEo
	vM1E42nQzopOgRVdJr2x57ooFt6++rCA6cfjXixV05AtiEj0eRldHobgvdwCPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nE2kbgjGWycT+/j2EegI16cfx8bb6rrnm0Qn32IUbV0=;
	b=NBgQ7zdUaS8dt0PnreZeoBQIiIiy9pbof0vyEd+vOdqJCozzJuP0G+sGEHXzaZvp8SoMEL
	YrGPgdeH6Ml8h9CQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] powerpc: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-42-jirislaby@kernel.org>
References: <20250319092951.37667-42-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545284.406.10313686356692798086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     36a0d76d23f94fc00feb7262d6fdbd05087f99aa
Gitweb:        https://git.kernel.org/tip/36a0d76d23f94fc00feb7262d6fdbd05087f99aa
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

powerpc: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu> # for 8xx
Link: https://lore.kernel.org/all/20250319092951.37667-42-jirislaby@kernel.org


---
 arch/powerpc/platforms/44x/uic.c                 | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        | 2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  | 2 +-
 arch/powerpc/platforms/8xx/cpm1-ic.c             | 2 +-
 arch/powerpc/platforms/8xx/pic.c                 | 2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 2 +-
 arch/powerpc/platforms/powermac/pic.c            | 2 +-
 arch/powerpc/sysdev/cpm2_pic.c                   | 2 +-
 arch/powerpc/sysdev/ehv_pic.c                    | 2 +-
 arch/powerpc/sysdev/ge/ge_pic.c                  | 2 +-
 arch/powerpc/sysdev/ipic.c                       | 2 +-
 arch/powerpc/sysdev/mpic.c                       | 4 ++--
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/44x/uic.c b/arch/powerpc/platforms/44x/uic.c
index 481ec25..85daf84 100644
--- a/arch/powerpc/platforms/44x/uic.c
+++ b/arch/powerpc/platforms/44x/uic.c
@@ -328,5 +328,5 @@ unsigned int uic_get_irq(void)
 	msr = mfdcr(primary_uic->dcrbase + UIC_MSR);
 	src = 32 - ffs(msr);
 
-	return irq_linear_revmap(primary_uic->irqhost, src);
+	return irq_find_mapping(primary_uic->irqhost, src);
 }
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index f042b21..3dbe5a5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -369,7 +369,7 @@ struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq)
 	mutex_lock(&mpc52xx_gpt_list_mutex);
 	list_for_each(pos, &mpc52xx_gpt_list) {
 		gpt = container_of(pos, struct mpc52xx_gpt_priv, list);
-		if (gpt->irqhost && irq == irq_linear_revmap(gpt->irqhost, 0)) {
+		if (gpt->irqhost && irq == irq_find_mapping(gpt->irqhost, 0)) {
 			mutex_unlock(&mpc52xx_gpt_list_mutex);
 			return gpt;
 		}
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 7ec56d3..eb6a4e7 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -515,5 +515,5 @@ unsigned int mpc52xx_get_irq(void)
 		return 0;
 	}
 
-	return irq_linear_revmap(mpc52xx_irqhost, irq);
+	return irq_find_mapping(mpc52xx_irqhost, irq);
 }
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index b4f6360..4b69fb3 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -83,7 +83,7 @@ static inline unsigned int socrates_fpga_pic_get_irq(unsigned int irq)
 		if (cause >> (i + 16))
 			break;
 	}
-	return irq_linear_revmap(socrates_fpga_pic_irq_host,
+	return irq_find_mapping(socrates_fpga_pic_irq_host,
 			(irq_hw_number_t)i);
 }
 
diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index 1549f6c..a49d4a9 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -59,7 +59,7 @@ static int cpm_get_irq(struct irq_desc *desc)
 	cpm_vec = in_be16(&data->reg->cpic_civr);
 	cpm_vec >>= 11;
 
-	return irq_linear_revmap(data->host, cpm_vec);
+	return irq_find_mapping(data->host, cpm_vec);
 }
 
 static void cpm_cascade(struct irq_desc *desc)
diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index 7639f28..933d6ab 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -80,7 +80,7 @@ unsigned int mpc8xx_get_irq(void)
 	if (irq == PIC_VEC_SPURRIOUS)
 		return 0;
 
-        return irq_linear_revmap(mpc8xx_pic_host, irq);
+        return irq_find_mapping(mpc8xx_pic_host, irq);
 
 }
 
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index a41649b..91a8f0a 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -173,7 +173,7 @@ unsigned int flipper_pic_get_irq(void)
 		return 0;	/* no more IRQs pending */
 
 	irq = __ffs(irq_status);
-	return irq_linear_revmap(flipper_irq_host, irq);
+	return irq_find_mapping(flipper_irq_host, irq);
 }
 
 /*
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 9abb3da..b57e87b 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -190,7 +190,7 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
 unsigned int hlwd_pic_get_irq(void)
 {
 	unsigned int hwirq = __hlwd_pic_get_irq(hlwd_irq_host);
-	return hwirq ? irq_linear_revmap(hlwd_irq_host, hwirq) : 0;
+	return hwirq ? irq_find_mapping(hlwd_irq_host, hwirq) : 0;
 }
 
 /*
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 2eddc8b..c37783a 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -250,7 +250,7 @@ static unsigned int pmac_pic_get_irq(void)
 	raw_spin_unlock_irqrestore(&pmac_pic_lock, flags);
 	if (unlikely(irq < 0))
 		return 0;
-	return irq_linear_revmap(pmac_pic_host, irq);
+	return irq_find_mapping(pmac_pic_host, irq);
 }
 
 static int pmac_pic_host_match(struct irq_domain *h, struct device_node *node,
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index c63d72f..4a59ed1 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -207,7 +207,7 @@ unsigned int cpm2_get_irq(void)
 
 	if (irq == 0)
 		return(-1);
-	return irq_linear_revmap(cpm2_pic_host, irq);
+	return irq_find_mapping(cpm2_pic_host, irq);
 }
 
 static int cpm2_pic_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 4ee8d36..b6f9774 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -175,7 +175,7 @@ unsigned int ehv_pic_get_irq(void)
 	 * this will also setup revmap[] in the slow path for the first
 	 * time, next calls will always use fast path by indexing revmap
 	 */
-	return irq_linear_revmap(global_ehv_pic->irqhost, irq);
+	return irq_find_mapping(global_ehv_pic->irqhost, irq);
 }
 
 static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
diff --git a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
index 5b1f8dc..0bc3f0b 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -245,7 +245,7 @@ unsigned int gef_pic_get_irq(void)
 			if (active & (0x1 << hwirq))
 				break;
 		}
-		virq = irq_linear_revmap(gef_pic_irq_host,
+		virq = irq_find_mapping(gef_pic_irq_host,
 			(irq_hw_number_t)hwirq);
 	}
 
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index f7b415e..70be210 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -801,7 +801,7 @@ unsigned int ipic_get_irq(void)
 	if (irq == 0)    /* 0 --> no irq is pending */
 		return 0;
 
-	return irq_linear_revmap(primary_ipic->irqhost, irq);
+	return irq_find_mapping(primary_ipic->irqhost, irq);
 }
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3de0901..787a88e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1785,7 +1785,7 @@ static unsigned int _mpic_get_one_irq(struct mpic *mpic, int reg)
 		return 0;
 	}
 
-	return irq_linear_revmap(mpic->irqhost, src);
+	return irq_find_mapping(mpic->irqhost, src);
 }
 
 unsigned int mpic_get_one_irq(struct mpic *mpic)
@@ -1823,7 +1823,7 @@ unsigned int mpic_get_coreint_irq(void)
 		return 0;
 	}
 
-	return irq_linear_revmap(mpic->irqhost, src);
+	return irq_find_mapping(mpic->irqhost, src);
 #else
 	return 0;
 #endif

