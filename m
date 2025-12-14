Return-Path: <linux-tip-commits+bounces-7692-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12376CBB877
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003983004CE9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA72F362B;
	Sun, 14 Dec 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TMluRUUW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4i1Bo1R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61872EC09B;
	Sun, 14 Dec 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701474; cv=none; b=K4ROLJCrw9uCxK+ftEHogN5DLE3DkUqH4+ERb3dNj0EC50/1E1eEnkluHGRqv8tEXr//TkBqE57URh4x7uHc8hP/WqsoEfgnm6/Q3zidSNjvZWPVFZW2kfGcGlNXHnwivvAZVLKcoPT8EGDRGfY0jU0zMPJ6dndgldVzX/t8DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701474; c=relaxed/simple;
	bh=KOUyDXEdqg9wl/MFEv8hh022VKWAI6iU2REJ2Qz634I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=keRxJnw9gsxGmI3hFhjzr+iPiDMd3EQ8turjFBM0irRgS/zPnpVcE2/v+sxMWXd8ykx3bhKpzWs0ym6iacuncILCUvjbwSMArGZ8fyhI16FcRHnQkfLRqX1Y0gZmCURuoFO0W1N5QuDiIUd7rCovINkpnPY5EfX2Rq/DmxE0GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TMluRUUW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4i1Bo1R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WzB3CiQyhMcn0bpaELdj4aTPA39zWnIZkq7YCEsejc=;
	b=TMluRUUW6aR2tNqQjQ2lYZkDgPp6QunzGzR07+owimmJFCrFz/E0wQeqH7k6NFOMjbsLB1
	Bz58f0Z0vnKWfgztCw80ZQUpgi4GPy7XbZ6NsPLyojqDkOyKz/NO/j+clAw6k+DwCQ6Unp
	JieIoQEAFaWn6ZOlapxC3msQK2KFFHqPOSyVw8t515AW+lmFhNYQNYvUzp5SS05wbcrJSj
	H/mCt4Xe5p1oKiuzo4ouORnC9k8Gwu0meLu3X14tQOn1KF/l1scLoIH8mgsK1zGKkWIEyJ
	ZZKaaF7Wja33O+81L1JH/8ZTYRmZmFe9C3vIyWTYP5O1TucHMplTyZNptvdTFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+WzB3CiQyhMcn0bpaELdj4aTPA39zWnIZkq7YCEsejc=;
	b=o4i1Bo1RdPp5jOsa33J9yyJXL6bJufw3QhKpQFeE8Z7tJSz/pq5lBqpPil3kSifyPyWRsb
	KyY30l80HY/JY3BA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Remove inverted boolean logic from the
 e820_nomerge() function name, rename it to e820_type_mergeable()
Cc: Ingo Molnar <mingo@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-2-mingo@kernel.org>
References: <20250515120549.2820541-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146869.498.5350734473926618184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     db0d69c5700ba4749217b83b475606d864d46226
Gitweb:        https://git.kernel.org/tip/db0d69c5700ba4749217b83b475606d864d=
46226
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:36 +01:00

x86/boot/e820: Remove inverted boolean logic from the e820_nomerge() function=
 name, rename it to e820_type_mergeable()

It's a bad practice to put inverted logic into function names,
flip it back and rename it to e820_type_mergeable().

Add/update a few comments about this function while at it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20250515120549.2820541-2-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index b15b97d..4c3159d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -305,18 +305,22 @@ static int __init cpcompare(const void *a, const void *=
b)
 	return (ap->addr !=3D ap->entry->addr) - (bp->addr !=3D bp->entry->addr);
 }
=20
-static bool e820_nomerge(enum e820_type type)
+/*
+ * Can two consecutive E820 entries of this same E820 type be merged?
+ */
+static bool e820_type_mergeable(enum e820_type type)
 {
 	/*
 	 * These types may indicate distinct platform ranges aligned to
-	 * numa node, protection domain, performance domain, or other
+	 * NUMA node, protection domain, performance domain, or other
 	 * boundaries. Do not merge them.
 	 */
 	if (type =3D=3D E820_TYPE_PRAM)
-		return true;
+		return false;
 	if (type =3D=3D E820_TYPE_SOFT_RESERVED)
-		return true;
-	return false;
+		return false;
+
+	return true;
 }
=20
 int __init e820__update_table(struct e820_table *table)
@@ -394,7 +398,7 @@ int __init e820__update_table(struct e820_table *table)
 		}
=20
 		/* Continue building up new map based on this information: */
-		if (current_type !=3D last_type || e820_nomerge(current_type)) {
+		if (current_type !=3D last_type || !e820_type_mergeable(current_type)) {
 			if (last_type) {
 				new_entries[new_nr_entries].size =3D change_point[chg_idx]->addr - last_=
addr;
 				/* Move forward only if the new size was non-zero: */

