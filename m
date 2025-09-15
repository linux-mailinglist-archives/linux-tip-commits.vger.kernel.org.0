Return-Path: <linux-tip-commits+bounces-6590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED261B571E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFE13BC18D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCEA2E2DE4;
	Mon, 15 Sep 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7LEmQQo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vjv1TXBf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DBD2E03EB;
	Mon, 15 Sep 2025 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922525; cv=none; b=qy8ajZFPOkV2pekEc4Xtc3UNl9BNytvf6WOFSZMWKwsCr7Wzx9jz11+pOslz2fG19NgapSn0hxzsj6GR7gvSce6EspPzTYwggnK4S0VZv+uuGzjq30UfP4oFlqB/+1BePTU5hy/f5uSmUM4iZ2I0XDpLJWHi4KcaXhV+ZW8DMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922525; c=relaxed/simple;
	bh=tpkD5NWuIAlKLczh/XtmwB+Lg51DAZEasFywBAq1gMk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TpX5RsRHzEooMkcHx8se61iSYBtaAafnbVtR5vstPiHEuWHKrms9VepmSaWH9ng5JSwW1pB2jbti/OIcJ3fgkZhaPPgbO2/NWvuuAqRnj73Qi3P6TDJ3rGjpz+UKNqR3PvyhEWPY9hlGsizB2Q83mNRjlHsoaiFE5AXbOTwd36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7LEmQQo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vjv1TXBf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 07:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNpv9TpvjzrzmxIlJhG1LaU8so72q7b3MZvI9ajvd4c=;
	b=t7LEmQQoKs+v2TNCLdl8CVZA/z13zbYfHrT3nvKMcP5i23N8f44BzY0irxb33RjOdDmu4k
	27z/bZ/RhCgZc2QuwcB0IFRCceCn7bUOtaSEIzsu5u8OYFXWh/qkzIWs81YPmMBQMf9eDs
	dAN0iKnJEoBDJm3bP3Y6MqbgOYbmqt61MO7S3I8cmBn5PCL+LPZL0MbGqXof5Ohs8VXz7l
	1M91Q6wed4uDh9fJ//joZWP2zT5Z+rhOmDYpjUffpXhKhmyvbvZkr4HzOfXIEJpVt9XGDI
	hvFQqKLtoPlUh8iI8DtJWZ4JymqVyV3S2m5OKbcBT7EX86xGJDeL9cUZQXpxNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNpv9TpvjzrzmxIlJhG1LaU8so72q7b3MZvI9ajvd4c=;
	b=Vjv1TXBfzs8LrQfEKcemszqypNELLQMCxWAdM4bnslpYL20YSoylOWWieitWeTq4nMbF0D
	IQH/ovFndQIvw5DA==
From: "tip-bot2 for Gary Guo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: update atomic infrastructure entry
 to include Rust
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250905044141.77868-15-boqun.feng@gmail.com>
References: <20250905044141.77868-15-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175792251986.709179.10442289702826132033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     17d9f8eaa87d40a2ff66598875a43363e37a909b
Gitweb:        https://git.kernel.org/tip/17d9f8eaa87d40a2ff66598875a43363e37=
a909b
Author:        Gary Guo <gary@garyguo.net>
AuthorDate:    Thu, 04 Sep 2025 21:41:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Sep 2025 09:38:36 +02:00

MAINTAINERS: update atomic infrastructure entry to include Rust

I would like to help review atomic related patches, especially Rust
related ones, hence add myself as an reviewer.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-6-gary@kernel.org
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 538778b..2f346ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3992,6 +3992,7 @@ M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
+R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/atomic_*.txt
@@ -4001,6 +4002,7 @@ F:	include/linux/refcount.h
 F:	scripts/atomic/
 F:	rust/kernel/sync/atomic.rs
 F:	rust/kernel/sync/atomic/
+F:	rust/kernel/sync/refcount.rs
=20
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>

