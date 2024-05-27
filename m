Return-Path: <linux-tip-commits+bounces-1293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421F8CFE07
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9987B1F21F0E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 May 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947513AD1C;
	Mon, 27 May 2024 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mj6ofQMe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZdQUltaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7451513AD19;
	Mon, 27 May 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805476; cv=none; b=n4MJYVofsT0ph53fQQYrUDDfPqVcea/fTRyMBwlAcSGfZGug66jZdg3YV9Y5J5W84F9PmnI5jPsSAod3oVtr3GrTGRYbytCho0129QAhldzyXnCokyka6FZXinfgatO3mfm4UgvABXEbA+4CfCJtmenTs3dLKXxRIDrIUOQT2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805476; c=relaxed/simple;
	bh=25UaZIn7YTbKRxYS+FlAhRZQaXoz0d3DkJA/s6olNCQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WWmt7q7DVacmD4gWqvyDUVT/SN5Bc36Kz+eW72IRfXjkjeTpu3QpbYDaMC8VuTfUYIU3UQhE42nKMk0AA8h7e2BbtuKO9roMDZBAgiOQTLi0JglA0UeGcQ9EzciGM4FWiTUqUGl402wUQghpo5hD5y8P9q9MxRzlp4TKLaxEBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mj6ofQMe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZdQUltaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 May 2024 10:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716805473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRzXPz6BNdvjCKefY1GIKXo0nmr+7vk6qac9ciJA2ds=;
	b=Mj6ofQMeknKZ6howsJ4SKT2+dj7LyLu54fXiNRJtirz2nWwN0b0Zvi3bIJvkjW2lUgu2e0
	ghmc5f5mnI7KY0ImXfCqXecHc/Uli4tYFYcCc9VLU/NPYKXB8m3+v28bm1PPsAzNV6V7jk
	iHB9Kr8ucayjkz/I4mdYQMtzTQnrWTQfVAxwl+OAfEBMrm0L4u8AFQ8ZLkY0zJSk/yp/KA
	TZ5Lq2LrenBmhf4IDn1B3S0FTtaiuJ2PpfLnEvb1xYUCwQ3D+NLBS3tqpKAdwlYQtLOqPw
	zWmH8+8EwGYMFQSpbDW3UF/1AMWZ6Zg/LR/ctIww+9zU/+QKq47VIvllq4RW0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716805473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRzXPz6BNdvjCKefY1GIKXo0nmr+7vk6qac9ciJA2ds=;
	b=ZdQUltaV4PUPmQ1GUCz+KvRqAnT4z/MhTpfvnZLIHEjLvkl6gguhjzYppvbluwffZxOmUF
	Ug4Zp9u3uLy6gkBg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] cleanup: Standardize the header guard define's name
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <171664113181.10875.8784434350512348496.tip-bot2@tip-bot2>
References: <171664113181.10875.8784434350512348496.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171680547261.10875.14861972090119187819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c80c4490c280a1678e47d34d2a335a58f1318615
Gitweb:        https://git.kernel.org/tip/c80c4490c280a1678e47d34d2a335a58f1318615
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 25 May 2024 12:45:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 May 2024 12:19:55 +02:00

cleanup: Standardize the header guard define's name

At some point during early development, the <linux/cleanup.h> header
must have been named <linux/guard.h>, as evidenced by the header
guard name:

  #ifndef __LINUX_GUARDS_H
  #define __LINUX_GUARDS_H

It ended up being <linux/cleanup.h>, but the old guard name for
a file name that was never upstream never changed.

Do that now - and while at it, also use the canonical _LINUX prefix,
instead of the less common __LINUX prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/171664113181.10875.8784434350512348496.tip-bot2@tip-bot2
---
 include/linux/cleanup.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc..cef68e8 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_GUARDS_H
-#define __LINUX_GUARDS_H
+#ifndef _LINUX_CLEANUP_H
+#define _LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
 
@@ -247,4 +247,4 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 	{ return class_##_name##_lock_ptr(_T); }
 
 
-#endif /* __LINUX_GUARDS_H */
+#endif /* _LINUX_CLEANUP_H */

