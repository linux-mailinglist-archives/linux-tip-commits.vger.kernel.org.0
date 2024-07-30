Return-Path: <linux-tip-commits+bounces-1841-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D159410DF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5290281249
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823081A08C8;
	Tue, 30 Jul 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEk0RRyM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AA7R6iFO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CDF1A00FE;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339609; cv=none; b=N0B+wF2dmOSQjS+qdD631r6KaptAzmvh8th3WBT3iOR6mFmxy/crlqxlk/slptPjcfNu9VgaqEKfJdmfW1gZjpNsw4H5V7BmDQvTVYdO0crU++y8WUK83WDGyruZMPXVcg2wVVk0G3abUnKINLYw9Msvwv7Q/EhadVhX+ypEGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339609; c=relaxed/simple;
	bh=fWCuNZH2fXHCRoV20YN23bE9rqAavGrwJ2pRhrWlDsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R4lTmxaCk5B64k0jV0XEm5/V25E6sDOJAWcAsCnBWbmb1zge898BRfDCz/cJrm2kdsnJt/1GEcWg1NMChF3P2/K7iFkH7Y5Z2ti3zcfD3WhRVWNFpQvGevQNXIWXEzRfVm2MgXu/rFoPaUZ9prlEnE7tqdXGvCWWAStcYhjsx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEk0RRyM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AA7R6iFO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTfy08DrHY8JN4SsW4JwT6au5jAlNY49pnATvV7kyYU=;
	b=nEk0RRyMdXnYtRdrTKCmnoS/PBtHRfcOHKVqvGg2NBq+1Bh3yR7iG4xtv+GOz8tBpJT58v
	iECHrfByUu9u3urmwlHJVIo4eE8WSirw9cVosGFpi98FiyJlN5K8rRGpXxXLvvG8pGpVYq
	A9/12EXXNEjwBf5EHpvBd9S8ln9d6Kr0FXisMCuKB9y36Cin1IRWBkM5R0qh39X5ABWcph
	C7JK1jpg7w1iABXK4CrQ02pwjbrJPGa5bqLrofbp3XHtytpOb7nYHB0IuPdjYfrw9fn87a
	wOIYlwbyNNOU7LqfcwVwVtqfTlFqlpXMgFWinXabUpIOgmNZhKoaj6XSjMzHqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTfy08DrHY8JN4SsW4JwT6au5jAlNY49pnATvV7kyYU=;
	b=AA7R6iFOFDUbgtwPnQlHQEMauPEXLPoly0wdDvrzSv+QnlhrhOHbDKAOlfExt9mZxEtmx6
	/GrYDbJELk8JuXBA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use !virq instead of virq == 0
 in condition
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-4-kabel@kernel.org>
References: <20240711115748.30268-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960158.2215.3509932048071104475.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     88d49ee30ca52ba9a0dd593860a1323426791710
Gitweb:        https://git.kernel.org/tip/88d49ee30ca52ba9a0dd593860a13234267=
91710
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:47 +02:00

irqchip/armada-370-xp: Use !virq instead of virq =3D=3D 0 in condition

Use !virq instead of virq =3D=3D 0 when checking for availability of the
virq.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-4-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index b29f3bb..c007610 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -542,7 +542,7 @@ static void armada_xp_mpic_reenable_percpu(void)
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
+		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);
@@ -737,7 +737,7 @@ static void armada_370_xp_mpic_resume(void)
 		unsigned int virq;
=20
 		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
-		if (virq =3D=3D 0)
+		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);

