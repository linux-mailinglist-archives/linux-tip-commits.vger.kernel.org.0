Return-Path: <linux-tip-commits+bounces-2657-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BE9B6D63
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EB6282567
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788B1E8850;
	Wed, 30 Oct 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c//Lp1sU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJVIcD65"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE11D1506;
	Wed, 30 Oct 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319217; cv=none; b=Ryv5tGOCKbKLTgQkTThQhB1YeBrfPZKg5N2KUKoMu9wxCs89392d/jlyHJNuGbIHgYdpbu4rHP/iU5HetzZHnU/hv1D1G06bJGZf1wwnUhjVMfKrbpl3gKXkDjjSRQt8x2moqmq62lactPsoFQ6cDMQ4QS+AM+cWtbuOM3iRDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319217; c=relaxed/simple;
	bh=4nvpc/N0QTtfIVehmzc8ev3nJONUZjpgi2kRD60o3yg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ui4i26hjgu413xgkJiblsgBPXDZKit4GzDinkIy21YJ+Rv8yg65Rex9HSP4glDygFQPhleysnNNVNkplWgaqw2wmHssBDTdbm78zOrXwJtVAzmsuowrL7W6VThm+bB2D8z71lyJ5Ev1zS6q+LsSzkKKVGIaPcdOznL2iznO375s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c//Lp1sU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJVIcD65; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XSjEVriAowUxdFSa7ufXNGrIOsrkM+m/ILtKd8Fr4w=;
	b=c//Lp1sU2lPj7qCiaYYSchhV7FgN59WAqNr7oo1pmrQpkv0Umz3/8OyMbC7/NhneHPblyQ
	ehBuahqrcY2IktY/DXPI57t0YaVbQqmko7fS0R9sXccVh2Gt1Gi+FVLsvUtTTnhPw9Uu3W
	cGWdO1+hNNOWbMcq0lCbMgvip4u4ygu3m0VW7DzqsdYWfOfw060xGaQXCwFjnhadM0V3wH
	txU5rteOTsv0lTt0btjHGFNDeh3l7EcOOKZlI8nhr5tykIipayveiI8SorvGLArXDzT74W
	DJY4wZNLZGWJEp2BhVZKqaUlERjMAH+u9sZGxvOf336AAIPjio+jEgYE53qWJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XSjEVriAowUxdFSa7ufXNGrIOsrkM+m/ILtKd8Fr4w=;
	b=RJVIcD65TyB6oYMchAI+ttH/NqwqkKqhuDKOBmwFmusMMKTcMS6IymRGiC4xjIHmcPLWPt
	s/YAjye/DVbwwpAw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Remove
 clockevents shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-7-frederic@kernel.org>
References: <20241029125451.54574-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031921358.3137.2588999393650888698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8dfb95f57be9a0ef163d0202e106fdfbf2634b99
Gitweb:        https://git.kernel.org/tip/8dfb95f57be9a0ef163d0202e106fdfbf2634b99
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:22 +01:00

clocksource/drivers/arm_global_timer: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-7-frederic@kernel.org

---
 drivers/clocksource/arm_global_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a05cfaa..2d86bbc 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,7 +195,6 @@ static int gt_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *clk = this_cpu_ptr(gt_evt);
 
-	gt_clockevent_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 	return 0;
 }

