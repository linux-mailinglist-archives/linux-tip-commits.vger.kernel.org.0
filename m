Return-Path: <linux-tip-commits+bounces-3040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE169E998F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234261887836
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C71B425A;
	Mon,  9 Dec 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZU3baM5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SyZFG11n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECB1B4254;
	Mon,  9 Dec 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756119; cv=none; b=EbolaujEyWZL/osF0eZewpm0Ib0Vgr4vKP351d2dtdXvxPAKonZSvCfqfRzgwZzJhIll9GUd4Zth3KJ4SG1RzQZhhQdu11TZc4DLuY7SMZIaGbhhsQ+KbOUh2pPVUQfDpmsl0XwIgMhWFtl3JZgyufu106Bdu8rI5mb/XnNEEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756119; c=relaxed/simple;
	bh=Zveyf2y6JQQztXt2KAqca2Ff4SogJo+4Tm2KZmY9OSE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EwmT02Be4yK4eriuSkQbA6+mdoYJuxdFwAQzP8LOAlurzshLG7NGP+ztdLyrmilBrqEpJxErqofLI2YBQJHhf1WVmA8M4e/CPvdaTewogcVxm2r5xHMMJ6WpgAjYvBxuObKKBZmPOydh8cNw4EoJW8tBHiiaKvvjAQPBNuckHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZU3baM5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SyZFG11n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZuhCP+5T/GqohUn1zW9JUz4GNmoMqhmMIh92d/CRy4=;
	b=HZU3baM5ocv7n8l+6fUEo12+CsJtxBKJEZaag9eEm+gHccDMIHbU5dlQTYeDDOk2XZw6Uv
	iwxrzUlOFopPUlMuLkIJWng/neBAkO9CJpZFyQAMD+P7sejPdUdvPW5fNdw2gc5cW+KF9V
	kZR3wZAFVkWWdHBFH3cn1C2J/N/m9aGkFQk67dPUmt1zQUt0VnId8iWRzQlTehwDvR4R6D
	UPAVlRydRoUYclc9mQIGAcQXTD/jlV0dJmp9oYL5waQpTSTXEi0CjjywCY5z6MFWPfjAqX
	J9/hqvQtwcPCr2/0TGao9Qym+JihHVHNQKY8tck0DCtEgbdrIl015WYITd3ucA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZuhCP+5T/GqohUn1zW9JUz4GNmoMqhmMIh92d/CRy4=;
	b=SyZFG11nT19rNIZG2UyI2L7hP4bY0RodZgEm7dEMFK0fpnM4ACDjU1E/FP6jXMQgefkgi8
	zQ5wb6RrVcQmV6Aw==
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
Message-ID: <173375611440.412.461290934693175639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     02c56362a7d3eccc209d5c00d73a06513d2504d5
Gitweb:        https://git.kernel.org/tip/02c56362a7d3eccc209d5c00d73a06513d2504d5
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Fri, 06 Dec 2024 10:34:36 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:32 +01:00

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

