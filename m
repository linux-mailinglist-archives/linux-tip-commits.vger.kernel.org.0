Return-Path: <linux-tip-commits+bounces-7253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D8FC2FDA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734A218C1198
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705583254A9;
	Tue,  4 Nov 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUg2oL/m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5FgNC3r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DA131328C;
	Tue,  4 Nov 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244270; cv=none; b=RLu1hgv07njPc7WRdFxU60zSgAcn5X5IggbsAs0NkBBtcDq1JqC3WG9qDqf6Ub0SIQOLFGgPHz41jW+YQLBFM6FY0pdQ3v5BmtdjO8vxNR3rnZwkjNOObkhhtX4Uv5v8NyS6mtTFPDeM9SEPzgFOZ17LEl0ij32WcDZIJizgiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244270; c=relaxed/simple;
	bh=lFO9iSKSZnRr+9lCIkNZBpAhFbz7714gJ0+nGLeb8zk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J5W1fA1WCxcXBTmNSUr5iYm1QvjJtYylUXypBJTSxk7qzdvryco+6G6cfu1iVytnw5t47zZfXOSTqFEbDT5ZZIeMUrgSXA9baLz1SQ9vFma1UKnp82NRiOiDmFYLwyuBXioeplI2/ph8yXYSiIzMoSfsRsrRJXlOLCZoops7dyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VUg2oL/m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5FgNC3r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBXZgnXKk5YcWBLIlWskfOq3/BBFBVnVxJUhnLwlglk=;
	b=VUg2oL/mzAr1uudLzp9blSWmKGuYb+mqzus8b7YU0K5LZV9N4YgjHPUaFpSprcP8LSHFqK
	LvFXKi5CO3YScld2y8BONO5pKF3mNZU6Mq+H4bVkFtd2tkwwA75pDf6gQTfYVVFWgYQ/N4
	ipBvDqgw/CTifgTuhhGxCVuZvqwfI78Lk1TymOOyobJU1sfdvn9igKCck+XLg7eeObN2to
	ld1HN6EecBAPXsGp7pLznqbvnGYrsTu3ZGDOoruiZOQCKfJ0J5K6e5ySIVgejsfIOgkovC
	9hWlpf1bzMY5d5djtzER7V17wBfRIE97IumfRdxcu/Q/E1K2cwIV9qC2rxd6DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBXZgnXKk5YcWBLIlWskfOq3/BBFBVnVxJUhnLwlglk=;
	b=U5FgNC3rUyV9jP7emRENXjsf3OGBbQ9SgybSbAsdThqumaJKS7L9VBBZ5k6PdAmf4LiQ+u
	po91XGlWbj1H+YDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] select: Convert to scoped user access
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.862419776@linutronix.de>
References: <20251027083745.862419776@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224426478.2601451.18275304249360861483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     3ce17e6909944b3f83b54915e36f5957f1327712
Gitweb:        https://git.kernel.org/tip/3ce17e6909944b3f83b54915e36f5957f13=
27712
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:28:34 +01:00

select: Convert to scoped user access

Replace the open coded implementation with the scoped user access guard.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027083745.862419776@linutronix.de
---
 fs/select.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60..65019b8 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,17 +776,13 @@ static inline int get_sigset_argpack(struct sigset_argp=
ack *to,
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from =3D masked_user_access_begin(from);
-		else if (!user_read_access_begin(from, sizeof(*from)))
-			return -EFAULT;
-		unsafe_get_user(to->p, &from->p, Efault);
-		unsafe_get_user(to->size, &from->size, Efault);
-		user_read_access_end();
+		scoped_user_read_access(from, Efault) {
+			unsafe_get_user(to->p, &from->p, Efault);
+			unsafe_get_user(to->size, &from->size, Efault);
+		}
 	}
 	return 0;
 Efault:
-	user_read_access_end();
 	return -EFAULT;
 }
=20

