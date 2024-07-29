Return-Path: <linux-tip-commits+bounces-1759-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A593F19D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3443B281106
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FBD1448D3;
	Mon, 29 Jul 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zXgZvhlt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eK0zKI1W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFCD143864;
	Mon, 29 Jul 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246587; cv=none; b=KAzvWMKtyF14FQoX/RqHFpUIW6jtYitXXReWPm5WxEAX108IQ3Dgz3bOdOuNi7RFZPuxPns+2JQ7vw/3FRhDaDOwatOOihKE9k/+m4YT2jnatsgCNh0eP+O+KThUsTm8UmOodisxZYqCx4oBoP4LsQ5ifElleIAaVPfYsUj4Fdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246587; c=relaxed/simple;
	bh=wTuZzZIiDulqudFktVVYt3LeSWgGdrfJYEXeNVostxQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f/OOaLO05YW6uy2y2UUKaGsso9Bd9fenEq7j/ZYa8IJIouEsIqdz63BSIaeGtKB+TtjrtNdKiL4dDXo92E25rEhuOmR5ry2OZWWehED/7knK0Es+1sysC52+V8Q9e6z0+LQu2FAH/xgjTrI4DLtTj8KfnsNixoiqluqXg6oX+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zXgZvhlt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eK0zKI1W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTfKTW1vpn0P7+MKdrYm5hBHD6U8GtldjU+tGYVTN8E=;
	b=zXgZvhltZItkRGYwN9blecqBVeBW9eMH+xJt9kSN9KKIdKVIgnnT+JanDJDO5akqXsdtx1
	1Lr1vCaSeE9pdPGnkzfJ38fJXdUG2uZaypdOqBLFVVrkPaqmi9fBnkdeZqDpw3BQtd3tas
	iCrSUK7heWRXuljnemvwyXfPFF678B+r5ABr3kKfWanQ02QkMFIr3ncUYbssHVrwmlzy6F
	ruJsZmTTGjKwi1Tgmz5fbDi52b45YUcWUthRTywubRO+7i1MikjnAZPX2HIJq66Xa+fYx3
	/q+tqPqCYumkNBcdcWR27Sx+xGt0hbcv6o0Wd0L4sg5alD6q7Rz2lVMVKneHsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTfKTW1vpn0P7+MKdrYm5hBHD6U8GtldjU+tGYVTN8E=;
	b=eK0zKI1WPB5005rZyRMf+tOYj6G5fpeKR4SEL0qi//l0k67Lc0a6rQZpJ4jd92RCyhim8r
	A+82IYt/3Sh/IgCA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Simplify
 mpic_reenable_percpu() and mpic_resume()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-5-kabel@kernel.org>
References: <20240711160907.31012-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658206.2215.15042975658051241647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e1ed69fb599823fb04372b2a02bc3cbf7deb23c3
Gitweb:        https://git.kernel.org/tip/e1ed69fb599823fb04372b2a02bc3cbf7de=
b23c3
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

irqchip/armada-370-xp: Simplify mpic_reenable_percpu() and mpic_resume()

Refactor the mpic_reenable_percpu() and mpic_resume() functions to make
them a little bit simpler.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-5-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index bab9297..6e35f3c 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -517,18 +517,13 @@ static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
 		struct irq_data *d;
-		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, i);
-		if (!virq)
+		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
=20
 		d =3D irq_get_irq_data(virq);
-
-		if (!irq_percpu_is_enabled(virq))
-			continue;
-
 		mpic_irq_unmask(d);
 	}
=20
@@ -706,10 +701,9 @@ static void mpic_resume(void)
=20
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
 		struct irq_data *d;
-		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20

