Return-Path: <linux-tip-commits+bounces-1825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77A9410C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE6E1C234C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7E19FA7E;
	Tue, 30 Jul 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fCNpRkX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/JKd5qH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0A19EEB1;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339604; cv=none; b=qqr2YxSBF+HCpcemQPzKCurk++4w31n5Q4GHvt9QyqYenSy08LSuoV3R8NwdH6REHIsT44MvDgZyPp0XAlkSl5pIS5BRivnZ08G0cmn//ik4a7zWS5pa6UoWCN/zbRMyid2qb72kRtS9JYDm6H6sDSlSpqX/WqiuVn0z1sZE37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339604; c=relaxed/simple;
	bh=4oA+OXgpfMvYSYZoivM04aHyK7HrVH3TPoOyDNMOSA8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RLwowrvdU5ESh6Qm4XFl0Z83wKL/xI5UXxsS1J6RIwSMGfa5S9Anu3cHZXrpbcyb3fqYZrwaHVm0c6ujG417oE50qnUM/V60XYfi6zBVwAo6kW5Wc7PqI56KgsaeVuY6nhzHlNZVqyxSDurcwtW740DI/dmV3DIZJd2z/AKNqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fCNpRkX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/JKd5qH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Pf9PM0UMAHVFn5Fj86o0uWjrffI0oz5zp/IzhemiCw=;
	b=1fCNpRkX1R640IY50T32c3B0FvinhqQI9ziBi5xrSFDXMgp3OmSTlhdmRD0GuRzP0VdELH
	a8I3tABJ29E7uyFoBKWxS3XhaZ/gt7/XrsleyFU3BQpoNSBCaFZKjCTS+m5KZMDj4v85VR
	SB/UgtMfrRblDucWo6EZULZMhVLb+o8v2KFzA0z9OGgUy+AZnG7mQvd/GmD+VG1LRgbzwj
	R3fCJc5X8eQY2Zl7RhM+KJVskxkmS29rP8xE/O1/q8NrCDdrM5F3qv85doaxC/POMTbRgs
	YWDGjpUP8WxH6qLkJxv3k9F2nax2sC0tWXuFO0uLie3CUgbndUkFVCi9ZRWeGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339598;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Pf9PM0UMAHVFn5Fj86o0uWjrffI0oz5zp/IzhemiCw=;
	b=0/JKd5qHzHJfdHl2zrBxd/RFVabj5DU6WDVEXwFrJONJ2VnmTH9oX4HznVanUQf+8oM7N0
	JGon2zi5N9/mdTAw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Drop redundant continue
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-7-kabel@kernel.org>
References: <20240711160907.31012-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959854.2215.15275371788182500742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     081b64cc872707f80a23e41f0ab12852716551b2
Gitweb:        https://git.kernel.org/tip/081b64cc872707f80a23e41f0ab12852716=
551b2
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Drop redundant continue

Drop redundant continue from mpic_handle_irq().

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-7-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 66e14f1..4abe0ea 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -673,10 +673,8 @@ static void __exception_irq_entry mpic_handle_irq(struct=
 pt_regs *regs)
 		if (i > 1022)
 			break;
=20
-		if (i > 1) {
+		if (i > 1)
 			generic_handle_domain_irq(mpic_domain, i);
-			continue;
-		}
=20
 		/* MSI handling */
 		if (i =3D=3D 1)

