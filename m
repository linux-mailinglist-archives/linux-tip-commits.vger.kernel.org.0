Return-Path: <linux-tip-commits+bounces-3019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DD9E9031
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AEC1886406
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 10:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76C21766A;
	Mon,  9 Dec 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcsByA/l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TVUTZ7jk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DC217650;
	Mon,  9 Dec 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740339; cv=none; b=fojozbEXcTXSc/nyJg1C9G1cYwHifTlArqzT8t0enBb2yLU5r1E3ZgIFRlTj0ve7AO2DMiq5zDyC1w2NWrwTai+D84pmh16uB5U+uYgW51Vud8B/7aXxQnk6CGo8D6bPJqNI0LRi1+4RJb8ajdFA9XdvvxwMJIcQH8pe7tfXVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740339; c=relaxed/simple;
	bh=dxiDYnAMOaTf1FUU7FEOOBbXR3KC5aKOLxecsh44Ss8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b2aMF0qxY4PY8RotO0WUVVyd/je13A48cXXvtR3F4ThFuI+NOIsvOILa3FN3WLfhExiTytFnMn0qOoq8yaI14Kugp8fLstpXOtbjAvf1vEy9u7G+nwqXmcCzqJIsX75wwdgcKO877c1P2zmjOb8uE1nDfFSBRx2R+MB4Ggi35v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcsByA/l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TVUTZ7jk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 10:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733740329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LweK9EDRmGIucmjIbLKijimSrAF6fUtdTRfJ5rVXJ4=;
	b=kcsByA/lQCfo2ELSbeKcSlr3ehwxWEaqfG4EeSp+TjqzABbZCLw58uEBK25VW0BmYvaEZW
	S4yw1IWU5qYWOoin7+N/eVfcC5imefzMbileDPEaAkcdoH+pcQZ/AnXqCqJva999VABkcC
	74SaaxW7aLtd2esHjXqe2EQ832OD7htEL1py9wPXYQr+T7uWI+6mUM9Nzdl+udKmA/Rt4d
	vYPlRuSJC1cvKB7PPBIrPvK0tHzyfYUjYWa0ladvEdPfexIlPTdDTncaOXUCZfkWEL0Cth
	AzZ78HdGKLt1HgU/HBvJ5FEmq8JosUSeUinRuDawnPJKEufJKrfBcMNQNwRLQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733740329;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LweK9EDRmGIucmjIbLKijimSrAF6fUtdTRfJ5rVXJ4=;
	b=TVUTZ7jkSXqo9R6VTcepSogZa88fR2mJvw24/f/k81DDoKshXVLcADM1k38u8s0y4utGAW
	fmyWHIa8inLD1bCQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Guard against kmemdup() failing in
 dup_return_instance()
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206183436.968068-1-andrii@kernel.org>
References: <20241206183436.968068-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374032793.412.1283775556101446957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     638331f34c3f19f5bf14611ec6092ca1ba0ceb51
Gitweb:        https://git.kernel.org/tip/638331f34c3f19f5bf14611ec6092ca1ba0ceb51
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Fri, 06 Dec 2024 10:34:36 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:18:08 +01:00

uprobes: Guard against kmemdup() failing in dup_return_instance()

If kmemdup() failed to alloc memory, don't proceed with extra_consumers
copy.

Fixes: e62f2d492728 ("uprobes: Simplify session consumer tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241206183436.968068-1-andrii@kernel.org
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1af9502..1f75a2f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2048,6 +2048,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
 	struct return_instance *ri;
 
 	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
 
 	if (unlikely(old->cons_cnt > 1)) {
 		ri->extra_consumers = kmemdup(old->extra_consumers,

