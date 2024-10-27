Return-Path: <linux-tip-commits+bounces-2615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8579B1F36
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 17:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5651F20CA6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60827466;
	Sun, 27 Oct 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alMr+RoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQw/Dmdz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4E161;
	Sun, 27 Oct 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730046866; cv=none; b=lOFc2ZiHHRUcYGcSYJo80eJ7WqzJ1XmO/Xzmh1twuIfApedActtRIifCLZi0/rZeqc6LzDR8fGJZDF7vr6Q8XqzjvvIaFQllVPKpSZAlLfYIjvKoA4+bGwIFTHdxYOpCbGkEaJxcxMxtAt2iH+eY2Q6glzK434tYxqIKxfxFP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730046866; c=relaxed/simple;
	bh=aUO2sswEH5odrMoyGn4idTZZaTm2XCmsVYe9g1IgQEE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AR9GhrmxdUCM0Rw6YUPRZSAf/VujoidfWkXlKweBUH3RTgHokyUkg52N/HuxtTOxULpWmSeR6UL2k0IpUPAIxe0Bnrt7Gn2ZqCj+wjJ2TfQuSeibj4CAuU+NQQpA1DSK1E9DNouToVuObjYPTCGAZYB4/F5JK3MsDd7V8ZghK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alMr+RoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQw/Dmdz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 27 Oct 2024 16:34:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730046862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojssyzoPGPmXzKMwCdEZ3FmGm0d9nJHNFYhkefKhUoI=;
	b=alMr+RoCjjErCMOUeXdMuBzGlZcrgqQ9OFilDwvnF+Hh260ljWvycH/tlKfp7iEHDQi823
	9DBtJBVc/u6XHNwgR6E5fABTDmu5UbUr/GB81n02m533eUfwpv5LMpGWaMUxY2n6gaCpib
	wRlUX03zTGf/pAIeTLKHP9o3GMgT0+ULKeysIbmog4PlvuQfmd1VKhmQGFiRjmmCBeypQk
	3NVDZ3tjnJgxI0g9DaFMF+ugAAZXNcT+WNXZqNx2lm+YX0jJn0FpKi3nypj/h0RPyWZye8
	JZMOEMZm7ysqt771UPJ8lZbHdVKAfghHo4fkK7/tbZ2i8jxQBmzcMLv5pa+Bug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730046862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojssyzoPGPmXzKMwCdEZ3FmGm0d9nJHNFYhkefKhUoI=;
	b=iQw/DmdzNBnkoLu17wyyCW3r4Bf/BqnA1AsyFmWTOtUC8/p8KpApdMvEnLzYW7P2n2qPq3
	pjlUi/xYvh0sdzAw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4: Correctly deal with set_affinity on
 lazily-mapped VPEs
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241027102220.1858558-1-maz@kernel.org>
References: <20241027102220.1858558-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173004686110.1442.16219393471791468722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e6c24e2d05bb05de96ffb9bdb0ee62d20ad526f8
Gitweb:        https://git.kernel.org/tip/e6c24e2d05bb05de96ffb9bdb0ee62d20ad526f8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 27 Oct 2024 10:22:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Oct 2024 17:30:16 +01:00

irqchip/gic-v4: Correctly deal with set_affinity on lazily-mapped VPEs

Zenghui points out that a recent change to the way set_affinity is
handled for VPEs has the potential to return an error if the VPE
hasn't been mapped yet (because the guest hasn't emited a MAPTI
command yet), affecting GICv4.0 implementations that rely on the
ITSList feature.

Fix this by making the set_affinity succeed in this case, and
return early, without trying to touch the HW.

Fixes: 1442ee0011983 ("irqchip/gic-v4: Don't allow a VMOVP on a dying VPE")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/all/20241027102220.1858558-1-maz@kernel.org
Link: https://lore.kernel.org/r/aab45cd3-e5ca-58cf-e081-e32a17f5b4e7@huawei.com

---
 drivers/irqchip/irq-gic-v3-its.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ab597e7..52f625e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3810,8 +3810,18 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * Check if we're racing against a VPE being destroyed, for
 	 * which we don't want to allow a VMOVP.
 	 */
-	if (!atomic_read(&vpe->vmapp_count))
-		return -EINVAL;
+	if (!atomic_read(&vpe->vmapp_count)) {
+		if (gic_requires_eager_mapping())
+			return -EINVAL;
+
+		/*
+		 * If we lazily map the VPEs, this isn't an error and
+		 * we can exit cleanly.
+		 */
+		cpu = cpumask_first(mask_val);
+		irq_data_update_effective_affinity(d, cpumask_of(cpu));
+		return IRQ_SET_MASK_OK_DONE;
+	}
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as

