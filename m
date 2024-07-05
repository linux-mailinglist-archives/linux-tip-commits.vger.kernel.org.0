Return-Path: <linux-tip-commits+bounces-1616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51D928E8E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841361F263C6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E202317A918;
	Fri,  5 Jul 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBFBdMrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5tdb8W8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC11176FCF;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213610; cv=none; b=PH0UXFIvsu+MTwt5U4JqaJVtzNSTG647c/NXUECusYPF/+nwSj387uFJKS9tIMSTqxlFtFgL6qprMXhZKfCehCYKDrZGlotgfaDWJYyzQNVeQlh9Ubl5I5jivEXwpNc5ic2aYQlEEd2KY1YRI+6NhBGHSKmZLhij71P1WFnCmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213610; c=relaxed/simple;
	bh=EwXmBvSut4hkPYgcaO1vap9pD4YkuE3/q8kNnoz6bfY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GPPI4nNcLCb2VzUIs2wWvwOJPtKoCa/RTU3L28MJuVU9e2yU5vKtdFIR2ARBuWHsT3EO/Uzn2mJ3AtaY/krZ7tLP78d1wihnbs2+t/TdbpnIhE8urPogviLzEEI3Ffu6yMhxzoSgkWVwmsSLM7YxtlloGJ4uj0Z8GNnwjFdvXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBFBdMrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5tdb8W8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WZZgDBw5HS+3TTtoD6UKkBNXvFZgAkB4RRBy+5yNyE=;
	b=YBFBdMrFHKDvpdrDGWkWDU9WyNSQcMOOoXNbWyCXliywebI6t1lypYc9O4EFzjfa72NICD
	5/yLWNaQTWchgWrBJahpcNb+5qQAJX2jE0RBmELbhMLjEmZBJujk9JyhGv1Fr+sYXucsoH
	bRieeIdEbvsN+fiMYjAmifkFzzEcl98LN0PvJYv5PbS6IIBLpJCS7ExHISO/iZ9V5pkaic
	ViG6ElHlVG1hyUsDFhqIUjfrLjm2yBaZ0XtS7JSzScfi0z+P5Mn8P7N6sV1Dr0BIvZCu6W
	C/DoReGwGIjUicDWVjFvMQqmvxxqMSz+32kOjAPI3C0uA0/3Tq2NjcTTYU32qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WZZgDBw5HS+3TTtoD6UKkBNXvFZgAkB4RRBy+5yNyE=;
	b=n5tdb8W8+HAvkiwoXZjtXRFUwO7mFPRZJCGSX1WFkBEtJwQ/QMmz4VXORHu51hpvk86XNN
	3/oWelRgrCDYbrAQ==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Fix pt_topa_entry_for_page()
 address calculation
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-4-adrian.hunter@intel.com>
References: <20240624201101.60186-4-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360654.2215.7593882763697789755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3520b251dcae2b4a27b95cd6f745c54fd658bda5
Gitweb:        https://git.kernel.org/tip/3520b251dcae2b4a27b95cd6f745c54fd658bda5
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 24 Jun 2024 23:10:57 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:21 +02:00

perf/x86/intel/pt: Fix pt_topa_entry_for_page() address calculation

Currently, perf allocates an array of page pointers which is limited in
size by MAX_PAGE_ORDER. That in turn limits the maximum Intel PT buffer
size to 2GiB. Should that limitation be lifted, the Intel PT driver can
support larger sizes, except for one calculation in
pt_topa_entry_for_page(), which is limited to 32-bits.

Fix pt_topa_entry_for_page() address calculation by adding a cast.

Fixes: 39152ee51b77 ("perf/x86/intel/pt: Get rid of reverse lookup table for ToPA")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240624201101.60186-4-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 047a2cd..b4aa8da 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -990,7 +990,7 @@ pt_topa_entry_for_page(struct pt_buffer *buf, unsigned int pg)
 	 * order allocations, there shouldn't be many of these.
 	 */
 	list_for_each_entry(topa, &buf->tables, list) {
-		if (topa->offset + topa->size > pg << PAGE_SHIFT)
+		if (topa->offset + topa->size > (unsigned long)pg << PAGE_SHIFT)
 			goto found;
 	}
 

