Return-Path: <linux-tip-commits+bounces-1290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4E8CEEEE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 May 2024 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D0F1C20A08
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 May 2024 12:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625B1E48A;
	Sat, 25 May 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pNhG/m95";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elRecitd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAEF101F4;
	Sat, 25 May 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716641136; cv=none; b=TeVRIMhfjlqHoDNU4AX0LnQIokBwT4Dye2RA7yJb97tPiCUwlJm4OxwYWvl98wKtyicME7XJOC4G8G3kwRz1nwebwb60Ypkan8bqfI8riXcv1ebacraP+29dQCWvZrv/H5cF2CeyX39I3CAtqkF0ZursSODScffLxTOjK/YTnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716641136; c=relaxed/simple;
	bh=eeAitaAmSAkbYaU04UOTjrZ7ojZYRcqsyQM0YGQFGjY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=J3pVNXPlVJU8ZxrAobVbK/IESyPHG5Tb0DwmAUvDAciyb0UhtiyC48hF6pSW271Dn0ka3ltxrLAqIFs0GxNF2wzT0CYsWvK3xEuvC6aFp4Qk0lKwoV61EIlIAfGX24nTEDiGwUoXJfSYdtsy9V/knjiwpghJQSIzQJeWALFs3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pNhG/m95; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elRecitd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 25 May 2024 12:45:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716641132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f9m3fQbxEulN8aOMpTnoJl+7t0n/1G78kbyvVi25U38=;
	b=pNhG/m95mlT6/4DVXjXKgAeFd4rW3z/doo7I2lyNa6wkPx9TtOgjlA9OwzoJebyu+BCSgf
	av5dA78KvQ4pUMHg9JGEU7o6gaoidjDJQLhdp58IEpEtvlSTxinDtWjBgfdyeJBWZCxf0x
	pDiMBoVGtIKqTsrYTPrYUMRTtxb7QAJjEfOVl1fHA/eK99u8/p/3o9cP7PdaPcBC1ur84R
	4zcWZBuqy6+c2KqPyw7F6VfGdlKjJLtUkiennr7KrY90ZNBwP8EgjJY2VWBmPXA/8uw8b5
	gI0D6ge89Y570JXQqQg0u1D2UnCS2anX4kuFa5UD8o/6SjiaS9OCCygDi3ITtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716641132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f9m3fQbxEulN8aOMpTnoJl+7t0n/1G78kbyvVi25U38=;
	b=elRecitdMgliBy2pg7Ome0/6GUl0TcR61ib2il9y/tANv6F0nL5G/DUyWN0hmPTstW3Vwd
	4Td8S7AlYACCqGCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] cleanup: Standardize the header guard define's name
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171664113181.10875.8784434350512348496.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     fda570c8796f8fbb3285fb7ac007ace9aabbbb68
Gitweb:        https://git.kernel.org/tip/fda570c8796f8fbb3285fb7ac007ace9aabbbb68
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 25 May 2024 13:18:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 May 2024 13:20:36 +02:00

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
Cc: linux-kernel@vger.kernel.org
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

