Return-Path: <linux-tip-commits+bounces-7046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64136C196F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC08B56553C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297A331A63;
	Wed, 29 Oct 2025 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Al81VQak";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ezWMtcRe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D5328617;
	Wed, 29 Oct 2025 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730585; cv=none; b=TiMJ7jNe+qsEqi8KbIZK4Tp0quk51X1cNrmrOC8LIUNMo8bZJ+havnhaM+PDhp1pNAThE8dymH0camMPgjMr9cfIsOxXc3qo1kSDY198aV9HMlFKmhdU6hv6rk5C6wLGhEkvJ8gW7b/7mrCiigXftqFWKp7bZKrbO75gBkrSIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730585; c=relaxed/simple;
	bh=amEXykoIYXHkivcVwoGDI6Tmf6TwBedjsv/t2AbFMz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IS6Gq/m9OAfhNDVWXQ1f7FOcjaZDTj1Z3woy2o+x9wUJyIEhhijVBaVF8VU4NKh7D4K01K+qDB398Aonv98otsgui00orxUIRXuFTFpjyp93gBZI+aUoS1pBMYye8KDczOaNroKQDguGc87QRsUM2qto2XAWK6Wu7GvSzHMdexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Al81VQak; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ezWMtcRe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtT27HgMl3zW6Crqm729ceEMNZhbtlkJGmsC/FkIaBE=;
	b=Al81VQakzsw5abMYc9cv3RtXiMsoQQUVU3hmIFgq8Eo7Wbd9fGeY8JmptBZZJy97PyNuAg
	I5gL8Bq08R2ZcQSkP38478AKiMUoWKh2pDeaXfE3kaTvnGh+H4qTJryjMZhqcB0yEthUfP
	FhvJKZVbewSBmpoHeMuupTLwE+NKXYS3fszxSMotwHXeDRYmDzFJEVI475LNFNd/vIUfG2
	BXUARYqdkSFJgqSGzqv+NU/c/qo5/cPJ0Utlfsmb4NGWvOUZ0S9pfABI+13oLNlW8amduG
	We5BE8xDPUxgNKQ6XlgIuWCo/WXFLBbcAzuzazW6LNKSO/z7f43NdPTqT4wdgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtT27HgMl3zW6Crqm729ceEMNZhbtlkJGmsC/FkIaBE=;
	b=ezWMtcReJOWvmk3Jyr3ZJ2NQvuEJZ6zDPaooJc/c4TaMXtYa1gJs1AgcPu1gUy1DE+TWGy
	5jlD1p6W6Y6DoNBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Add required include files
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080118.665787071@infradead.org>
References: <20250924080118.665787071@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058043.2601451.7700465496222921145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b1164c7d118defb01a885b53f56e3336db784df7
Gitweb:        https://git.kernel.org/tip/b1164c7d118defb01a885b53f56e3336db7=
84df7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:44:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:55 +01:00

unwind: Add required include files

To be self sufficient, the file needs to include linux/types.h. This
provides things like u32/u64 and struct callback_head.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.665787071@infradead.org
---
 include/linux/unwind_deferred_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_def=
erred_types.h
index 33b62ac..29452ff 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
=20
+#include <linux/types.h>
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;

