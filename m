Return-Path: <linux-tip-commits+bounces-7804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A5CF495C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1983A30BC947
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DCB346E62;
	Mon,  5 Jan 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6tx9/tI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Awh+H/TK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE6346AE6;
	Mon,  5 Jan 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628474; cv=none; b=stYMMJIxAAO9ln60+cgewvLkSS6oHNZz7GCLGB7U+cIRkBJ2SrhsUR6Ry8aixZ8Z2tXYLpHL9znYsJNNSx060NKg4+ghnaqPBN3Jxq4ap3CzqBcHphHdVG6U3WOesIFA5vENONn3jK9gdqCgkDlVW67ooqFJSvfEIbWdvFQLbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628474; c=relaxed/simple;
	bh=ndgdVIf/qhadxrW+UTM6s9b4KZGCMRN6XZgUo1L/QPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EKIBzvswHtM+uuD1Ks68F/r6R6jjMBGM1yq/fJUbToRqPgQ2TRHsGdk1YZpPz3lPFr338kMdmqhPXqUUMDufhym/TV2L8qFxWFmRbf+zjjNFv8TJXLGgjSog2F+J2Ov/b5mTZEYBvlpKVFQCmR1mcQ7TqzhprSTQyCrFl6iQ01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6tx9/tI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Awh+H/TK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iSpiMSLUmcpuLjI8/xszh6ktc4LB1989G0VaIVo1pk=;
	b=D6tx9/tI+KxQP9oIunrrYN4wCEgKEj9Ekai2vU3uX26EW+5c8rE9ccqw2PuO9jCxDcXOwi
	7ZL80wSME7t/n6D9aCa/5uau9Svs6aYeAUBjYEJe2EKhe/hev/LE8UCQy/F5tGBVkidzS2
	gA09Zn8mUKipEp+PTYiVLAR4rJzk6oUJi9n7QI3z13/f3Syy148crMGjdpLtVZCA+z670C
	eDo1LfmNJcKdvAT1Zy/lWsSgY1KfOh2wpte7Okt0b7UbrXx/Y2mWHat9BYtm6OmWaC3IKY
	z4j68PqyCHOB0vI6lt3QzLKjjnJfUuaBFW7Sf3vrjnYRlEhSokjCWflbHVb+vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iSpiMSLUmcpuLjI8/xszh6ktc4LB1989G0VaIVo1pk=;
	b=Awh+H/TKx7wv0mD4xgQj5gcp81THHPVy+JEWqRC7KBDXzrpjsgL/eC+1QXe96QArLfHLvi
	vKKhI3dcvn9UaSBw==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Include missing headers
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-19-elver@google.com>
References: <20251219154418.3592607-19-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846930.510.10425726824967101932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8c9c8566e139c0f1398245fbe3aa409fc1a79da8
Gitweb:        https://git.kernel.org/tip/8c9c8566e139c0f1398245fbe3aa409fc1a=
79da8
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:31 +01:00

locking/local_lock: Include missing headers

Including <linux/local_lock.h> into an empty TU will result in the
compiler complaining:

./include/linux/local_lock.h: In function =E2=80=98class_local_lock_irqsave_c=
onstructor=E2=80=99:
./include/linux/local_lock_internal.h:95:17: error: implicit declaration of f=
unction =E2=80=98local_irq_save=E2=80=99; <...>
   95 |                 local_irq_save(flags);                          \
      |                 ^~~~~~~~~~~~~~

As well as (some architectures only, such as 'sh'):

./include/linux/local_lock_internal.h: In function =E2=80=98local_lock_acquir=
e=E2=80=99:
./include/linux/local_lock_internal.h:33:20: error: =E2=80=98current=E2=80=99=
 undeclared (first use in this function)
   33 |         l->owner =3D current;

Include missing headers to allow including local_lock.h where the
required headers are not otherwise included.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251219154418.3592607-19-elver@google.com
---
 include/linux/local_lock_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index 8f82b4e..1a1ea12 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -4,7 +4,9 @@
 #endif
=20
 #include <linux/percpu-defs.h>
+#include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <asm/current.h>
=20
 #ifndef CONFIG_PREEMPT_RT
=20

