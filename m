Return-Path: <linux-tip-commits+bounces-5303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FAAAC5F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAB61C200C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BF028852E;
	Tue,  6 May 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQyUMnz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2fKVhCS6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6A2882BC;
	Tue,  6 May 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537642; cv=none; b=LjG+QxchGBwvq7wvT2reEfpBebitF/qLr9eNP1v7z/CcHDJO6wjvNwxnRmCkqHchd9CbXDpvr1GLsZExZyX6b3d6XPo5JSK2sJe7iKzefMs/UgmIlomSTCzvO7g4MaJDNXdBc+d2ZCDhQ7YG8d2qTsp/YhDRPMzP/Nk/0iEqUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537642; c=relaxed/simple;
	bh=PEq5504rKhdvSsmUwEhTBk7ijJgtiLFH03dmVruR1nY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MAOXGhABak8xzNxhiEUT01NXJfKlRVlHPMhz92+U9gkWjrpfOjezGeLPSyJblWKuJ9JWixyAFwpMA0WbE0Y0AUC6RxU5j1Bs+gBNUZT3yH11/PYucNSaiEFz40pphF7foQ/QcVjzY/5dnTyZNhK+fDUm/uHT0zXPCbuK7VhmKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQyUMnz6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2fKVhCS6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CAub93ncZ99DTtL2bNpwijyFObQ62ZOWjXFs+E02ow=;
	b=lQyUMnz6zwhQYAimEv32svgpbBNjj3b5gfXe9pNPEzx+d/03eHQfYnIj5DSmKjaJioBnD/
	ZJtPQP13DRnieLknHoSeNNp6U7KuktGb2o2yIGv8lkybVud30GHNKgkuiKofrTiY3lwfJ9
	JFO7gUaRtgx21ueQhKejYearD8IMt1LdrmZtHcT9Lc9NyzmhhKb0KSEIBeVMaHwjQrE8jN
	X8KIv9DlsVEyliw5lVsIJG5hovLerR3t+Abk98Ekl/yn27mSbO3y4HEb1PrUNicTCRlY+D
	WpHvSTLiEfsNW3taxjpKF34QGrTk6ZH8gKAfc5ldlnpUJd+d2wlJWbJK3bd6Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CAub93ncZ99DTtL2bNpwijyFObQ62ZOWjXFs+E02ow=;
	b=2fKVhCS6/VKo66dRFdRJAzCPFGinroLomkNUG3dDSftiFF0m5lNKduGkQ51iEVDP3ufbJK
	skJjju41PDz1HUAw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] bus: moxtet: Switch to irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-16-jirislaby@kernel.org>
References: <20250319092951.37667-16-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763777.406.10157787958371534908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     35453b137783ea3721c27566f56e8edb4bdb2736
Gitweb:        https://git.kernel.org/tip/35453b137783ea3721c27566f56e8edb4bdb2736
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:04 +02:00

bus: moxtet: Switch to irq_domain_create_simple()

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-16-jirislaby@kernel.org

---
 drivers/bus/moxtet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1e57ebf..6c3e5c5 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -737,9 +737,9 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 {
 	int i, ret;
 
-	moxtet->irq.domain = irq_domain_add_simple(moxtet->dev->of_node,
-						   MOXTET_NIRQS, 0,
-						   &moxtet_irq_domain, moxtet);
+	moxtet->irq.domain = irq_domain_create_simple(of_fwnode_handle(moxtet->dev->of_node),
+						      MOXTET_NIRQS, 0,
+						      &moxtet_irq_domain, moxtet);
 	if (moxtet->irq.domain == NULL) {
 		dev_err(moxtet->dev, "Could not add IRQ domain\n");
 		return -ENOMEM;

