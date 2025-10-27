Return-Path: <linux-tip-commits+bounces-7015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92DC0F52E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B49074F2983
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1A319859;
	Mon, 27 Oct 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JEae3Bq9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePmi0YZs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04F3195EA;
	Mon, 27 Oct 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582673; cv=none; b=GDyWqPHtrN3jQ2ykdB7WedRAuceJPwXTnRKvQ7QHvoUTe5cnUc5l5+tIkOraMmcMxIFFXdrU5Kibzu8+xQ80TwrcoltA20NOjrzh/J5UJX/LUT7LAFWJUa85Bbe2mOuoOlcywbxp77ozqUW4XDHy5JDG1SZ/UVw+0FftLyDdGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582673; c=relaxed/simple;
	bh=pcII28slHH9qnxsOG0nSI2vpWTzayvQe43ijaMkTsmA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FUOtjokGS46kK9Z3BTeQX3p/iFwgAPBavUe+hf2iKMwrW0AkO1HU1Z8AXWJ6nLHK/9jY4Zwj+1GDeJgdLEbh1hNaCnCGTcQyXTWCTmJzdmXTvgf98mp6D2wBqUdB9b+bGVfmB+llsvJwl4FvnqhDp0YaWxNlr2rBBuOz+qjWJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JEae3Bq9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePmi0YZs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3ZWnwcngzIBfi8TWYrsMs3zM79MhSjLIa940bnJmyw=;
	b=JEae3Bq9T9gNct2eif3rrzMz+K2GXApvDW4cyCXaqlt6sGytdcuNMMnsJC5vVHWmpzM9Oq
	KeqZheVH0V2sor8C+aTsGcM66A9zepj5jb1YVdYslH8KupY934ujf8PdfPp27GB4UBu4O+
	+XMoKfL3MDMfJKECXcMcaLZBLlxc2drXqMpNWiqWtjlCGtN4l0RJBidQtJb27QWI4nvy03
	oyPMz6XPCqL1L3uGmRwXKBf9UNruAA/xG2mnPQeizn1LVVW2uqqLUJwTxALK8MVTNcpJeg
	2PB+HmTmd9RjO2rVeWFwUeBA4EJkMzNbsesTDQ6dJ0pnsbHt0tBZj/irAK7f6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3ZWnwcngzIBfi8TWYrsMs3zM79MhSjLIa940bnJmyw=;
	b=ePmi0YZsyVewMc0KXASZHLd9n/rUiRmWPKd9rUhURewyBrsWIdjyodLljRytnkYfIXRncm
	Zcv1UGEQyGHe8OBg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Merge irqaction::{dev_id,percpu_dev_id}
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-13-maz@kernel.org>
References: <20251020122944.3074811-13-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158266898.2601451.15365637821999717576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5c2b2cc472e015e79c4f0170893a1e0883bd3bb4
Gitweb:        https://git.kernel.org/tip/5c2b2cc472e015e79c4f0170893a1e0883b=
d3bb4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:34 +01:00

genirq: Merge irqaction::{dev_id,percpu_dev_id}

When irqaction::percpu_dev_id was introduced, it was hoped that it could be
part of an anonymous union with dev_id, as the two fields are mutually
exclusive.

However, toolchains used at the time were often showing terrible support
for anonymous unions, breaking the build on a number of architectures. It
was therefore decided to keep the two fields separate and address this down
the line.

14 years later, the compiler dark age is over, and there is universal
support for anonymous unions. Get a whole pointer back that can immediately
be spent on something else.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-13-maz@kernel.org
---
 include/linux/interrupt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 51b6484..0ec1a71 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -121,8 +121,10 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  */
 struct irqaction {
 	irq_handler_t		handler;
-	void			*dev_id;
-	void __percpu		*percpu_dev_id;
+	union {
+		void		*dev_id;
+		void __percpu	*percpu_dev_id;
+	};
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;

