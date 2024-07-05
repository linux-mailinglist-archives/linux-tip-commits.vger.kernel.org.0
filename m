Return-Path: <linux-tip-commits+bounces-1615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CD928E8C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D6C1F2622C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7117A58B;
	Fri,  5 Jul 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fUDBgP6c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sw+zfnng"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC894176FAC;
	Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213610; cv=none; b=iZah0+JxtKDTbKSuuVC65XcVky4rOk7keaGskhuW0fqEa25QxGYrNxlP8GNRK1OP3XL5t+/PWazdm5bnJR7hs0RKcrVvft3a5WDtRV139xm+i6BBDHDbVmCt89MicbQsfyBtiVHaVea8g7PuvDbUk2MbYu1MHq1eod8cqTjwruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213610; c=relaxed/simple;
	bh=LvnrRSxJPnUwbnZ+Jze5KDQVHNFaOuJ8ICTN03tKfL4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LhPz8awbF/moaF6l+AlqlGTpLAQGzJyAVwW/2L3aCFFSHgME4G0JjqqTHyNLoSCs2VFmf95EnF7lHE3erzGQVIp2r9n2WI7gYGNxsznEQzkkWpyOeUbJFSTC66eg4Dc4ScL7JpxTtNcx84x+ixdr3HuhKqRe2cuHZk2mCdTqH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fUDBgP6c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sw+zfnng; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI9tvdp2XKPlMZ1ofum0IEP7l3zIOakA60YYSCns4hQ=;
	b=fUDBgP6c3Hge5/s7pQHY/1ZFHJDUGfBEZ/BdXHH8ZZ7W41shFjg0L1ToFTwJ8MCD4u26yk
	W02U2BgKohlZ5YSBPp6JZNy4IvAVsoMs8ifsvHbk8lTbIimGIt+TCSS0p4dlZYFU8l3baF
	U+cEmHQUOmQ3wpHygUqAnZD3ofA/rvEY38apsTM1xqBeLRhSXN8R8ERODk5AqOdgfS7iAi
	A7fWdukeJIDjtVnVr/LK1xftWEZOPqGuWS80KRFDEvojeFPlnKn7z4tlPSNkRBpNK1nhVQ
	JfXqiaKm+C63jdW5yssTid5/K0aEt7Du9Cs6mb3qksWkeK2YjvUQb79LpUCuVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lI9tvdp2XKPlMZ1ofum0IEP7l3zIOakA60YYSCns4hQ=;
	b=sw+zfnngnBHC/lhINSPmK0KgK139R833aK8VWBFdXdKTMve30TvPoHSn6LJUuRcEEW2z5x
	8FHha6jV/mmp3TBg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Prevent passing zero nr_pages to rb_alloc_aux()
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-6-adrian.hunter@intel.com>
References: <20240624201101.60186-6-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360585.2215.1715448644937258588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dbc48c8f41c208082cfa95e973560134489e3309
Gitweb:        https://git.kernel.org/tip/dbc48c8f41c208082cfa95e973560134489e3309
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 24 Jun 2024 23:10:59 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:22 +02:00

perf: Prevent passing zero nr_pages to rb_alloc_aux()

nr_pages is unsigned long but gets passed to rb_alloc_aux() as an int,
and is stored as an int.

Only power-of-2 values are accepted, so if nr_pages is a 64_bit value, it
will be passed to rb_alloc_aux() as zero.

That is not ideal because:
 1. the value is incorrect
 2. rb_alloc_aux() is at risk of misbehaving, although it manages to
 return -ENOMEM in that case, it is a result of passing zero to get_order()
 even though the get_order() result is documented to be undefined in that
 case.

Fix by simply validating the maximum supported value in the first place.
Use -ENOMEM error code for consistency with the current error code that
is returned in that case.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240624201101.60186-6-adrian.hunter@intel.com
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6b0a66e..e70d3dd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6496,6 +6496,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		if (nr_pages > INT_MAX)
+			return -ENOMEM;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;

