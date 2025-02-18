Return-Path: <linux-tip-commits+bounces-3415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33905A39789
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D4B3B4BAB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30B23957E;
	Tue, 18 Feb 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QsS9tPxH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqzpT31r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8E236A74;
	Tue, 18 Feb 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871996; cv=none; b=uJ3zGqioWE/fojDTXVjQEzJOXWwbKeEJsOqAoI24/8xTl7+Z8WmMgGeBl7lLivcHiy0qkhNqLSM1GUGo0cgX/rxd8hD6Lv57GjOOPOeN9WDI34GsBJPFbEW/gg08yebVMguuIQKurAd9+NobY53AWZdSKPWLcg21T3KUEu6s7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871996; c=relaxed/simple;
	bh=ba0oiQ58XdtjhOA+yjxuL4St8WCuHowauTmiMjq0bic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZHBbkPsVjcvkceKzN3IfK/bjdli25DlxVIY3Twy/a1CXawu8+835oVjFP9yNKFRPBWyPfCaIzPpsN6iYul6Zi1aE+oCo5GT1VbjZ1MWpbRbt1BefQhKgCOmhhs1adOg1fRzGBuClcFUkfGJQs3bHi5CMnCDBtZkZyOi+EBgJtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QsS9tPxH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqzpT31r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/XmGtCMo198upY18CkXtNHNwENhggIvPZcY3aKiyvk=;
	b=QsS9tPxHGzG5gNOvv92Aim2y3iHyFQcv86qClOJ60Wg3mRrA9AvGsYXHc7Ep/tjOzzgNRs
	PTFtO29RbXS5yaNubK7mGx4V+R0MqF79Y0tDzz21Ez3z63Ig6bRcf2XY44lkCf+EXGgpZ0
	45Dc26fdF+KeqOlwh4iVMNwBxKJwR7N+aLQMoKxk/ScbovJecNz0sXOMlxMdpZJaHEwDhd
	tXL/mnVMf819EZ7xrZ+uAA2SXCrvlUPOqUzxPSrXzgyUr7NXg8B9+UQYuMSXjoOxH6nh8y
	D9L8f2tXNha9ocZRV/pGbH2imlhzo9v0i2CJku3EOOPxZp7RTAj/i+ND57rL4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/XmGtCMo198upY18CkXtNHNwENhggIvPZcY3aKiyvk=;
	b=TqzpT31retuXMgnsBzSKL5e+WeVdcw0zBrdTLYJvRywqGrAxB+jqYXqAGCBzvZ6TC46F05
	cQd9upzHApKLnUAQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] bpf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce4be2486f02a8e0ef5aa42624f1708d23e88ad57=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ce4be2486f02a8e0ef5aa42624f1708d23e88ad57=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199275.10177.16778177784113921215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     deacdc871b48a6a75b03837e8faf3e0cd7c198ea
Gitweb:        https://git.kernel.org/tip/deacdc871b48a6a75b03837e8faf3e0cd7c198ea
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

bpf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/e4be2486f02a8e0ef5aa42624f1708d23e88ad57.1738746821.git.namcao@linutronix.de

---
 kernel/bpf/helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce16..672abe1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1284,8 +1284,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 
 		atomic_set(&t->cancelling, 0);
 		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
-		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
-		t->timer.function = bpf_timer_cb;
+		hrtimer_setup(&t->timer, bpf_timer_cb, clockid, HRTIMER_MODE_REL_SOFT);
 		cb->value = (void *)async - map->record->timer_off;
 		break;
 	case BPF_ASYNC_TYPE_WQ:

