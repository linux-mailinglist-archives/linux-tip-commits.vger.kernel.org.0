Return-Path: <linux-tip-commits+bounces-2575-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3D9B0C65
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EAC280DFA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DD13A40C;
	Fri, 25 Oct 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bU7HY15l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaUW9P/E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98420C326;
	Fri, 25 Oct 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879275; cv=none; b=PtiDXdOipWBYqlo1Bky+Nd9LBJRMaYVA2ulLxbVosEozUHDzJ4GL7vCjElnltOuJeRbxGSDKtmSx4YKGTNd0wOFOL/qUCyHHTwpbO184joekubgkWyKn6obOeyTAvN4ojq/BlPPhpFPyufAefheZW/h8XcHs5chac+JvUogX2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879275; c=relaxed/simple;
	bh=x8CZHayInUEkHDL3QVPFGqkX+ENVSTOhs7fu4S2yZrY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OyE0LPDJhlqX2A6U4pbI5YDCtn++eAocCsuusuWGQOeZEXtipmvqFNZ9+U8YrY1olou5dEkZMrDQn3t2ZlaZYMP/mTU7Lb7fvYUvcj7DbtKCqikxu7h8Ewot0ty5rIDR1AnLH67VnpKLP4G/Xrr7M2FGiyBWfPaLHbUOckaIXHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bU7HY15l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaUW9P/E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNnBcdlWFmovmxH9wzOjO8Y59qwyGDvIsV2etumXdQ=;
	b=bU7HY15lwuQFhXAIsvcqAYWZWb8wwxrNQDyaNDZjeRchqGC7EMsA0LMtaZPbTPPIeyDHj2
	1oNbDgDXaHGkSm0H5tINhZtyV+4JHLVNGqHt8bS0QcX8XJT7oN6iovEU3NAeEWNcB3HPA1
	gK3ZWjRlumFtQ/i+n6MNcVspGPJKqkpzVOaHbCZHRdEizwYuh8z6w7HkO8SmUbFLwwYD8h
	1a3E2nvev7PCku9I+yF1vJ9s8FnZhDMtI6POYIgBz/2Ri7QkxIsqAHnxBYIunUWE4BKioo
	Q7ydBMYVLTToV8OFGuLf1kBgfUy+Pun0OB74lrzYc8ghlPYExYQ5xVqmtF/CwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNnBcdlWFmovmxH9wzOjO8Y59qwyGDvIsV2etumXdQ=;
	b=YaUW9P/EPYVKlAX/TPu+rUnpAqV9I5wyLW7ZyWOHRY5PGBQ2HNX3tUO11klngz3bS4G9s/
	WCHrKjT66Ug5RSCQ==
From: "tip-bot2 for Miguel Ojeda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Fix references to _msecs_to_jiffies()
 handling of values
Cc: Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241025110141.157205-2-ojeda@kernel.org>
References: <20241025110141.157205-2-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987926907.1442.10531063821416197986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     92b043fd995a63a57aae29ff85a39b6f30cd440c
Gitweb:        https://git.kernel.org/tip/92b043fd995a63a57aae29ff85a39b6f30cd440c
Author:        Miguel Ojeda <ojeda@kernel.org>
AuthorDate:    Fri, 25 Oct 2024 13:01:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:50:10 +02:00

time: Fix references to _msecs_to_jiffies() handling of values

The details about the handling of the "normal" values were moved
to the _msecs_to_jiffies() helpers in commit ca42aaf0c861 ("time:
Refactor msecs_to_jiffies"). However, the same commit still mentioned
__msecs_to_jiffies() in the added documentation.

Thus point to _msecs_to_jiffies() instead.

Fixes: ca42aaf0c861 ("time: Refactor msecs_to_jiffies")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241025110141.157205-2-ojeda@kernel.org

---
 include/linux/jiffies.h | 2 +-
 kernel/time/time.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0f..5d21dac 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -502,7 +502,7 @@ static inline unsigned long _msecs_to_jiffies(const unsigned int m)
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
diff --git a/kernel/time/time.c b/kernel/time/time.c
index b1809a1..1b69caa 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -556,7 +556,7 @@ EXPORT_SYMBOL(ns_to_timespec64);
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the

