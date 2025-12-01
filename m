Return-Path: <linux-tip-commits+bounces-7564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A737C95BE7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 07:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B7AD3425F8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617D221DB1;
	Mon,  1 Dec 2025 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iWRoUqpx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDj6UX6p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4B21ABC9;
	Mon,  1 Dec 2025 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568884; cv=none; b=DcIn0GEKK9OHRrUKKxKA2NTGJc1SwELHTr8MxBd6dNVzlgfHOOsPbn7p+0tgh/44z3CFZcNdHjYRU3uqfUH0an3fMxRgNFw/i+/fn2ibduJHoMx4PGMndkFex94XgEYdl9OGuRSUrqvNLH3Kx3Va4W7DXdz0BjEqZ6p/QZj6ULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568884; c=relaxed/simple;
	bh=BjDyE+q7vhGihvt/AnwEUzpeDcxjiwbfIryViCij7mU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uyMgAT5heErA/M1+7Uct3iP9DQaxvKQBm8rKhHjCKrLkPcc5BTewaZiwDBFde3w8LQskd2gUFPHDIwa+RxqZ27WtoNN7VDdhTN7FXXsrJy0ZUXCas3aPgVrs3ubBNaxZ2+w2J3pG0tErO8gHzNx1HBt/Jy3Hxp+sZPdO0chw0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iWRoUqpx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JDj6UX6p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Dec 2025 06:01:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764568874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojfx7OCuC3y3Q77eXrj1dClRn6hpd3kU07eTki7xR7s=;
	b=iWRoUqpxfEtfnQFB0NgjkDTweohRl3BATvZP6BXvG7ivQVtszsRihQxRotyM6vuCiIKWcV
	Z8Wf6T41WxebM6I7ZDywJrk9YJTIhlmdg1BvAXLHZ4Xa8utBGyF3pODRYnVZZisw6Pq1qR
	EtQ4dV9eiVRJdoTSxRQy+Sias8vfPN6OBGsQRmasD85WDOe411GSWib+P8Q2FROx2K1+uV
	+X5u5fbScFeCApvvmSCt6v/RNuf3blVoa3zJSeeFq4l67pmG2JUWhMohCNnZVGB09t7zuU
	jn3omvCDQDHuejEXxLgAIvYGvGpr/JZusWXPRBoxdylOXCaIKyMLBspvS7DW2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764568874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojfx7OCuC3y3Q77eXrj1dClRn6hpd3kU07eTki7xR7s=;
	b=JDj6UX6p961dwB01PMIwTTV47vFICUU9PRwKHOxvm6QeiPW43haT2Fjluz/bfZxtwwh9LV
	NzvfwoKaNPuP+vAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: Add the <linux/local_lock*.h>
 headers to MAINTAINERS
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251127144140.215722-2-bigeasy@linutronix.de>
References: <20251127144140.215722-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176456887366.498.11227603155294634926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     52ed746147140e30419ee852c1916531b4ef9b0a
Gitweb:        https://git.kernel.org/tip/52ed746147140e30419ee852c1916531b4e=
f9b0a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 27 Nov 2025 15:41:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Dec 2025 06:56:10 +01:00

locking/local_lock: Add the <linux/local_lock*.h> headers to MAINTAINERS

The local_lock_t was never added to the MAINTAINERS file since its
inclusion.

Add local_lock_t to the locking primitives section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

