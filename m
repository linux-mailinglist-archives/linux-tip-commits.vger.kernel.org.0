Return-Path: <linux-tip-commits+bounces-1757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCC793F198
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0601C21CA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E9142E6F;
	Mon, 29 Jul 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZZ/FRyY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHxbk5oP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3D13E88B;
	Mon, 29 Jul 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246585; cv=none; b=XFsOry5yzu5sm+FtjDVLdqoGByIKOyNL2uCerNec3xz38oVI5UgYSS2DQbdZDlsneUxpfePVKBnM1pJ8rEGYkXUwUknwQnniIT0lwmZY/DTaSxyfhHztxC57ieRMN7YSApfZMe30WF98tpZO4Fkju+e1krl/DpCjPzhXKSKi8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246585; c=relaxed/simple;
	bh=EbRuQkqJF60sOD561dTvUF/yhBipP5/lFbqpksUKsXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hG2ZiqSebkER7GFzAUxYk9gfiMPfU8YapkSC8xrG4NWkfbDxTXFK/zuemyjkkqSJ8UZuqp7/PnUakK9bgDFl7oZmO5IF2fV7mLrPuWAdadGehmuj9jKqviWO2IHJLZbFZ5zPeDj0mLp+nPMBALYFnYjHqMCn5jn9uZBJqGcbTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZZ/FRyY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHxbk5oP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ9Q/t2TLi43nI5T+7Ja50SmvY5DFQfmazZaLtSDtbU=;
	b=MZZ/FRyYdoGkrEVPhK0aMwfcVbqlPPiMYX4BWbsAuoFBf9GjK6M9vrqusUsfVDgLE6+I+D
	5gFJFb/3WzkSfEyr3d9suo1SNV+KlTkILoXCYFggwtpR9NLOg/3IJ27GSi8oijssCC66/b
	gw1ZE1anMaZkVjB3Vxr5C0LatuoX+1cbZw+NjwV61WL7kq1sLSrfUIkOCOeEz6Gp68w9MJ
	n0jGk9dQnmuTUfVaqdGJhh88/bjFSouB/odSYPTNNFW30gu+q16XfY/sJmM400Q4H9YEHq
	VMCyy2sNJf/J1DqAT9N3mpZj0xlxFlPtHXtgPQVdMYtyNo59vKVV6B3IzMvv+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ9Q/t2TLi43nI5T+7Ja50SmvY5DFQfmazZaLtSDtbU=;
	b=tHxbk5oP+UYajhnNPsJEQVyP51IKPrK93os/X5d9mhv2BqhLXMBSGqj3P62Xde+bbwwoZX
	LTatOFG0v5woTeAg==
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
Message-ID: <172224658184.2215.8797194639091961384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9424aba41d43204236fe0d1af322c021d14b9f8a
Gitweb:        https://git.kernel.org/tip/9424aba41d43204236fe0d1af322c021d14=
b9f8a
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

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
index 6e35f3c..c1085c7 100644
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

