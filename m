Return-Path: <linux-tip-commits+bounces-6336-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A563B32F3A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AA53AE67C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F227E056;
	Sun, 24 Aug 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNktflFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6hHNh1vL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D920279331;
	Sun, 24 Aug 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033581; cv=none; b=VInBimStFMzIxwiAJSMmZ3Hf+oJfo1YxzTpNcMXIHZ6eGp2yK0aifwLhCzPRAkSH9B4lsS55ZaCU9uJrQ8N1AQ1hFy5kEPGcgbNyNaEoYV+pMtNnZ13F7gC+SOckWBu25Wvw6T6RnmDiuBMaP9MdmOuH0aOwSLF09o05/3gZw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033581; c=relaxed/simple;
	bh=9JR1Hr+Ma2nBJjPFNsblmYdO4k0k6gycLiGln8wLLoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sjYQRvIbdnZhmagOYFPsh4BREMdj0j1Q7H5iD3V+hurfxyefO2/dW4eLO2BCio/mHr/MEkPPVIsTEpO+hB7ej+uZbjECFM/aG8Uh5XbPAbERzkRYwH98jcWnNx6EisvzLrGsIdgOvzzNfzFyY1sHXPiMjbOBaGTb3n2thCG2rpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNktflFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6hHNh1vL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 11:06:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756033578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pM0Aiz0clbbsX/VIm41WMruqsg8r+QmhdCgQcbN58Y=;
	b=pNktflFC0PbRa/qGOdRCLp6+i3FvtEEIjXFUnqC3Q263ZTcvDBbIZiBa9dLFTDWIGSmQ0k
	LC/B/hVRfvgDHVxp4ToQCdnDBmevumJ651izph8MlkV6KKrSPm5QaheDPYfKFOdsycBlJ4
	pnMEJhrlIILy8wzeScod7XuFlpaMlgvoe+MWrj3WVa7cXOTBGapEXD32tYaReLkeH1w+LI
	5OxYG8Pzjy3lpWpbq5Js29RrpR/EysnGwrQ3XNfeHv0YFKWjTjc1N3ePnVWjPv13oFp+tA
	+L/0xDsFda6DFwKqZSBeEgnkwT+u3gjnNvhAD4VFm1BcVgO8zIMV1jTUHAIZ9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756033578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pM0Aiz0clbbsX/VIm41WMruqsg8r+QmhdCgQcbN58Y=;
	b=6hHNh1vLzL2OTv3c33gYcjvyygRqa96iY4j+WEKrqCk/BAgteUuYV9WlL1IaqYnZER6xBT
	7LWvq0PxeEBOx3Bg==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Remove undue WARN_ON()s in the IRS
 affinity parsing
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250814094138.1611017-1-lpieralisi@kernel.org>
References: <20250814094138.1611017-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603357760.1420.8506598326624626295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     35c23871be0072738ccc7ca00354c791711e5640
Gitweb:        https://git.kernel.org/tip/35c23871be0072738ccc7ca00354c791711=
e5640
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 11:41:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:54:06 +02:00

irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing

In gicv5_irs_of_init_affinity() a WARN_ON() is triggered if:

 1) a phandle in the "cpus" property does not correspond to a valid OF
    node
 2  a CPU logical id does not exist for a given OF cpu_node

#1 is a firmware bug and should be reported as such but does not warrant a
   WARN_ON() backtrace.

#2 is not necessarily an error condition (eg a kernel can be booted with
   nr_cpus=3DX limiting the number of cores artificially) and therefore there
   is no reason to clutter the kernel log with WARN_ON() output when the
   condition is hit.

Rework the IRS affinity parsing code to remove undue WARN_ON()s thus
making it less noisy.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250814094138.1611017-1-lpieralisi@kernel.=
org

---
 drivers/irqchip/irq-gic-v5-irs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index ffc9773..13c0357 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -626,12 +626,14 @@ static int __init gicv5_irs_of_init_affinity(struct dev=
ice_node *node,
 		int cpu;
=20
 		cpu_node =3D of_parse_phandle(node, "cpus", i);
-		if (WARN_ON(!cpu_node))
+		if (!cpu_node) {
+			pr_warn(FW_BUG "Erroneous CPU node phandle\n");
 			continue;
+		}
=20
 		cpu =3D of_cpu_node_to_id(cpu_node);
 		of_node_put(cpu_node);
-		if (WARN_ON(cpu < 0))
+		if (cpu < 0)
 			continue;
=20
 		if (iaffids[i] & ~iaffid_mask) {

