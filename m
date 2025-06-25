Return-Path: <linux-tip-commits+bounces-5913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CBAE8988
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891F0188D86C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B42DBF75;
	Wed, 25 Jun 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJQLiUi2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3JBU+13H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8F2D1F72;
	Wed, 25 Jun 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868173; cv=none; b=lvZkOvsaAvz3FVnRvRgEP5XTO8GuuzgOEdkLdFs6/2qyiimR0aTxJNiKO+BmcakC1rcfSzldZPbvfhyv/C/gOOgWucL+WdmONAfR1E0ad9iYHCDdITNBOwGE0MGAHxsSj3g08BFK8QgsNe876U++rFzrYo1WqEH3OqKn1Y/a/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868173; c=relaxed/simple;
	bh=dNeHiOaL+s4WuA4ML3MliobjSxf3ZgeKH5p0jNSk090=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TNbqnWHdpDMyKQpJBE8lC2y550hCpT4Ew1eY9McM1pLvHRbEbeU2NrWXoJOw6qmT+2410bz7nuOmds8zANUeLuYBuBmaz3NlN+1tG9KJaVzHqmvrr77Y3NQj8VAJ1yr3OkV6QzCn4AhrO3of3C0et5epDz3VifiD/uuTABtODEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJQLiUi2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3JBU+13H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Jun 2025 16:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750868170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV5KKw4Su69oXg1YIitTcU/tbJwyi933PR7fgLZ0w0E=;
	b=HJQLiUi2F2tZm7eVQzIJ9rHFJ42rYfO9nen68luqjc4eiVZISB97VGX0vXV9ZYeE1sSvR5
	GJsxb+9g/1HLwExaX+Fcc2M/MEpTkDjI+LUKdrnT4VWME11nnlHDBHI77/qUdU/WH6vkAJ
	bBeu0Dbor/lE5f3CvffOCh1fOagxLqfEuqi+uc4FbzsviNAFZoSlcs7lkMKn1cCensvqkU
	83sNhzMDXb1MA2o4cnMNm59tQvwfqYMYl1e08djLmc9yXqArtVZmk+5PhCSksbf0HxGxdN
	jhdRHKTjv/3w6rukAuDjJciJQx/YEnbrdKNwzoRmY3PCiw9hFB+pfDpzixCWNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750868170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EV5KKw4Su69oXg1YIitTcU/tbJwyi933PR7fgLZ0w0E=;
	b=3JBU+13HOwPm9DGeI7NCudUeYRZiI6k897NPcWRZErWEaKedh7ukvJxPYgwHh5dmdn4ubL
	fwJ4RB5mWWodeECg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] timekeeping: Remove hardcoded access to tk_core
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250519083025.652611452@linutronix.de>
References: <20250519083025.652611452@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175086816917.406.11370283047280648441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     990518eb3a71c357ca4ff1ad3e747fb844d8094c
Gitweb:        https://git.kernel.org/tip/990518eb3a71c357ca4ff1ad3e747fb844d8094c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 May 2025 10:33:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Jun 2025 14:28:22 +02:00

timekeeping: Remove hardcoded access to tk_core

This was overlooked in the initial conversion. Use the provided pointer to
access the shadow timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20250519083025.652611452@linutronix.de


---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91..2ad78fb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -663,7 +663,7 @@ static void timekeeping_restore_shadow(struct tk_data *tkd)
 
 static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int action)
 {
-	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+	struct timekeeper *tk = &tkd->shadow_timekeeper;
 
 	lockdep_assert_held(&tkd->lock);
 

