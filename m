Return-Path: <linux-tip-commits+bounces-2505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F59A2E05
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 21:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09741F21050
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9622738A;
	Thu, 17 Oct 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWKghfCv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsCi+pIK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC248219CB3;
	Thu, 17 Oct 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194291; cv=none; b=UQeGd2jaoAbqb2gCt9nuTa2VSxofRc8LGo5qxZudPJPPQEtSrDVnwy9Cn8bp/aoPp7JjqGZk0GIItZU4/9Ta9xWph13YDdmW7LfIJPU6wi51Et676UAmiVyLlKpr9j8t04nRToxibmyCiEqi575eLkAQJ3wgf0v+9MpY1aVeTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194291; c=relaxed/simple;
	bh=GOqhObK9WVXxxlUNgKST7m4TOnqBJ5yqem9LZsGSZkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L57x9RJGJLi8hpdfpQbrnMmlTQB31ZYWYBpBnJzw5gaBxlFcci/D7Rmhrdebbw3P3Y5J2vdchYIkmToN9WenOiA7J56xKMY3eoQAebSPS5P4i/Pr/HjeOtTQM5lzqbTjXM4Td/AnHoZ+OmOKUOpjW1oJYsjIIzdmCILbkADH6Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWKghfCv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsCi+pIK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 19:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729194284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgjib1eboi6cYJN6t8xN/u/j4+6fbFg84/y2skgXgpc=;
	b=XWKghfCvEi0C9aPOBjCpOn/xDn32bphxO3jokiPgDNXbI5qGVClJz3xdG9bjKRZn/lhNH2
	za2BiR3n/wL8F+ou4znY84QdZzwTXKfryHUrwVx+oTy2hLw8ZztIrZxYy6qj8JNpZ+4p3m
	i5fjZqmXLZ/Jl01ixWnwQOUS64JggOsLaaOusqrnMvTN4bwmc/3auy2Zda/VvfkFByKJLG
	dl9z2BYD0BFSYvxUw99V30oiS/+ddfqPaAdJXOWpzUEQrbQY9haHMlvOSTJP5LsiHkcKCT
	4Q/k2WbszURvvWNftkT1/A63E5SElt0Z2LRTOTKFpodS6frjRa2ZGz1eDd9xYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729194284;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgjib1eboi6cYJN6t8xN/u/j4+6fbFg84/y2skgXgpc=;
	b=YsCi+pIKKwf1VV+vBIS3XzTsmV9RVpHz7lADKHqU3xea0ePIwLwHH0koEc2VxHw8f5lYE7
	i80vVGZr50zDl4DA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] MAINTAINERS: Add an entry for PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@denx.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241015151132.Erx81G9f@linutronix.de>
References: <20241015151132.Erx81G9f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172919428374.1442.14035577890487137223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5ec36fe24bd2d529ba415b9eaed44a689ab543ed
Gitweb:        https://git.kernel.org/tip/5ec36fe24bd2d529ba415b9eaed44a689ab543ed
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Oct 2024 17:11:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2024 21:33:30 +02:00

MAINTAINERS: Add an entry for PREEMPT_RT.

Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
volunteered and asked for the list.

There are no files associated with this entry since it is spread over the
kernel. It serves as entry for people knowing what they look for.  There is
a keyword added so if PREEMPT_RT is mentioned somewhere, then the entry
will be picked up.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/all/20241015151132.Erx81G9f@linutronix.de
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f..cdfdaef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19523,6 +19523,14 @@ S:	Maintained
 F:	Documentation/tools/rtla/
 F:	tools/tracing/rtla/
 
+Real-time Linux (PREEMPT_RT)
+M:	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+M:	Clark Williams <clrkwllms@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-rt-devel@lists.linux.dev
+S:	Supported
+K:	PREEMPT_RT
+
 REALTEK AUDIO CODECS
 M:	Oder Chiou <oder_chiou@realtek.com>
 S:	Maintained

