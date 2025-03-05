Return-Path: <linux-tip-commits+bounces-4010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59308A50693
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F9C3A6F74
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328741957E4;
	Wed,  5 Mar 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="La/ubBuo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGGhjON7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE4250C15;
	Wed,  5 Mar 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196395; cv=none; b=iWFBB8f4CRRQUnlw6yAx5B/gPMF9OXuf1+7V8Ay59UM2V7pQdJkZedmqzeuOtrLrLNm/SMXAZym9i3SN65yZ8KtNnpQ9V4TgWbdsVJRGxABygQYgtVUjnIR7CJnOHmj+4n9U+6Q91Svps+b3/GRfzHnP4nzMZJpr5mVsz6apE7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196395; c=relaxed/simple;
	bh=B+wbsjjvgCYl9ZQMWL6LSAg8MKud07UMpiyZnW8Xl+E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fU7C4vMXopb1B4eQ6Hy/EMYUD21h5c1EAkJSoI+SvPBkC8pUhk8JAFlXKTtV/Cly9JbiYpihd1EegNw+pWqriEuVX3V+nzrauoB0yCkJxhfvF7JvH5JX1McfPHAuhU8IcJxcEN+WtjR31gvtk1A5FtEKmWo0GzGLhtqMFTYJIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=La/ubBuo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGGhjON7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 17:39:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741196391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD/lCQtBjMJNbD0fOBlfS+eJZmQe0QKwAmFitlBa5Ys=;
	b=La/ubBuo4cVbrPE7UH1UhTaVfI07Ah7f4IujA2Q4q9nFmjE+EHiQz7ifFF+j9NmpeJ2Hlk
	XFbukU4cFc+k64cSLj/djm0HV5mzWrPV+d2oujf+3mqWragKgzHbV58Z0NIzuTrbuWEoZs
	t3znlzcMVUTS/zpQ1xeGI3qQ5w2TNC03EgQ05/Qd7lHb9YPcm//p5JbpQMx1TNVtUhc/2C
	lxHM7AapbCB5bR6y83AvUI/OqSxC93QGcaCPpdMaikuouUE96thhuyEGA+Rwohqk+hqDPg
	Jj82cY6bmMWtAtBI/MQ2KA3plHSDPZi/CwmkGFq0PkkdIn4oDqQO5R2JsWMUXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741196391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD/lCQtBjMJNbD0fOBlfS+eJZmQe0QKwAmFitlBa5Ys=;
	b=UGGhjON7JVMY18oK92EZg3bTmoAnipdi614nWP80BpAWgy+wGK5b5LglKVzgBrm00Ipp8d
	i6Nd9vpK+nU354Cg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Annotate struct bts_buffer::buf with
 __counted_by()
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250305123134.215577-2-thorsten.blum@linux.dev>
References: <20250305123134.215577-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174119638803.14745.5873726326719106728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5e7adc81ae1b27ff565714d2933b291cf1e1271f
Gitweb:        https://git.kernel.org/tip/5e7adc81ae1b27ff565714d2933b291cf1e1271f
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Wed, 05 Mar 2025 13:31:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 05 Mar 2025 18:28:22 +01:00

perf/x86: Annotate struct bts_buffer::buf with __counted_by()

Add the __counted_by() compiler attribute to the flexible array member
buf to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250305123134.215577-2-thorsten.blum@linux.dev
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8e09319..953868d 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -58,7 +58,7 @@ struct bts_buffer {
 	local_t		head;
 	unsigned long	end;
 	void		**data_pages;
-	struct bts_phys	buf[];
+	struct bts_phys	buf[] __counted_by(nr_bufs);
 };
 
 static struct pmu bts_pmu;

