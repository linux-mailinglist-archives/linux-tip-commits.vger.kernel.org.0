Return-Path: <linux-tip-commits+bounces-7561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C8C93D3D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 12:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C633340F16
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C098A30E0EB;
	Sat, 29 Nov 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYOjGgE9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VD8cGo7W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C631E3762;
	Sat, 29 Nov 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764416991; cv=none; b=G45tvyOYSKTwhHjV8qAf2PHyqroDW5VaTroPvOZ8fEd999c9wqVGmqxuGbxuhT7svNrxX0/bpUnkGH5eZ2dnPfXRkPaLiARz6diJHX5j3QXfR+bTEeitx9RQDyERfGwOj+POzsCs9/dumMLue5LNENblx/FBHSdu5mWHHy9g7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764416991; c=relaxed/simple;
	bh=SM/E6hLTD1hakScxnF8NoQhgvndEOpxPO4OECOLe1KI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fPlmAgfNC7+UBDpHXuhHUVSxyIC4BUCdoUsG3uu6gCLQTCkP3IFfupa5PAQ07ZxPGuGZX1ToEPhPsR6ggRN4HkGnSpdzgKtBXiFB3wpUVYX7GxKQhf+KlcJfbTOvCABTsaRAmLiyV5ii3ttE63F+niAjpcpiIVKZyQA1e+8X91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oYOjGgE9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VD8cGo7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Nov 2025 11:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764416981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awUHVVbwBD1bAdriSIzfPlQb8gXCwowFfeDfKUqme6o=;
	b=oYOjGgE9Ku2XafNCSSxS+/zhlWksAa7j5wztvS/rGkbNvZ1CkbUF4TBPIc0gJJmR1lVyuZ
	blrgyNGYPO5zUfJ11/kH9xKieXusVLWx7OEuB68t9BYTQLZHp5Jb6RfPSgNt84OTu8RI8T
	VkXKcEWMn4jPTNubL0UmsA8TQYoggecN6d4Rm99wMczz/iZecfXL5mpeBvNqUd6GOVUo7n
	lS3oUu6NAnnYVKx3oddoj2nDOABqMak9yDD6u24H+XJ2WcGpU7K6Wf43av1NSzxB1qWcnh
	y/7rzIosq/BEx+ADJy1pnBL+4zD7AN0ptXWQkPStG/vFOTimwLRYuJ488cvVNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764416981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awUHVVbwBD1bAdriSIzfPlQb8gXCwowFfeDfKUqme6o=;
	b=VD8cGo7WmVyvqMweVv8mftkO69AXc19DErWweGKIULwptxuXmGUXbaEEh649TSPF2MpxKm
	tFLQv+n1X/MaQNCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add local_locks to MAINTAINERS
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127144140.215722-2-bigeasy@linutronix.de>
References: <20251127144140.215722-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176441698053.498.13048143098937723384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     477ee187604d2169f52e570dc04dadb33ea78c59
Gitweb:        https://git.kernel.org/tip/477ee187604d2169f52e570dc04dadb33ea=
78c59
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 15:41:39 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 28 Nov 2025 11:09:01 +01:00

locking: Add local_locks to MAINTAINERS

The local_lock_t was never added to the MAINTAINERS file since its
inclusion.

Add local_lock_t to the locking primitives section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251127144140.215722-2-bigeasy@linutronix.de
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a477..a099b9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14517,6 +14517,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
+F:	include/linux/local_lock*.h
 F:	include/linux/lockdep*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h

