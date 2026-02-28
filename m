Return-Path: <linux-tip-commits+bounces-8272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHxvA9HKomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF191C2690
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829CC30FEE7D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D442EECA;
	Sat, 28 Feb 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvXqxAG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vBWNm++i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2BA42DFF5;
	Sat, 28 Feb 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276204; cv=none; b=iVvLHi65XhAoXpCK6MWBO8xv+iztI0KdQsdPAyzr+qCXVl+ulpP9Eu/25y4koXtp/y/i7hvfK6yc6y4QavJC5oBTzezm5/fk+W/J5IJwTQ33hM/vCXDTXvnm6eB0Fsai5a9QukSBfSrwuylSZb8cPAKObh3lYnaGL2PWMqHPR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276204; c=relaxed/simple;
	bh=juZcEaXgVQsTk//uLWC1ISHC6nMxUNZ87AGhrRGkNc4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lzFxc3Pb/EToeN7x8EJwyDdRiyKJtl6pc8d9gsXPtsrPeiG+PHG9rbyPay0VtQO0cNyDm6wh2t/s3kzVhoscKuyYnUMjRMz0CUY9eU9UwHOY38dhBsxPDcT+a4wxzfTFNbSdZsWz25ZyBogbKE+tQ+xSRINT0gCePiIwCfr6KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SvXqxAG1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vBWNm++i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1abNSZC1LfwKqkFVjGDriiCimm/dVl9cYgOm+YwPfQ=;
	b=SvXqxAG1sp1w/4rNvSwFHLnyHiP68ZXilvy9ucGktmRpbJGe6lm6EqNbvtAWVyKDmirT1W
	lCxC4kpsvQmrCBhLzntMS+I1lfglgY6BTXtF2Agm4hA7bocDWWO4Av6ngdKBVfkx9BvADL
	oOECK50+oqOChBzd0SqnEfzggPycoPHkegMUNNcuz3pGzKHUJNELqmUAZcLD2yi4CkxUh3
	ka9ZiOLEJxCGzxy8MbZOm7jCFEANN93vJLjDXOpjSsBSJhAnFNgaNZteiibx80oaUoGIO4
	bialcUGM9w6i54cUjuB1t6NlD7cynRJ7Zac2PpF5KprFFl5+lxsgLs7oibd5TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1abNSZC1LfwKqkFVjGDriiCimm/dVl9cYgOm+YwPfQ=;
	b=vBWNm++iejU0MGIhlC6jd4dm3mx6+SxVroV2PO+ZcUsq0XflT/AzVctO+61KS3AVa2nSGf
	qi8i/aNat2Y/8LBg==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Define macro for ldlat mask and shift
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-2-ravi.bangoria@amd.com>
References: <20260216042530.1546-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227619998.1647592.5564607460036659372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8272-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6DF191C2690
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f9d55ccf0199d1a80c2519084578f0c345dedd2f
Gitweb:        https://git.kernel.org/tip/f9d55ccf0199d1a80c2519084578f0c345d=
edd2f
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:24=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:24 +01:00

perf/amd/ibs: Define macro for ldlat mask and shift

Load latency filter threshold is encoded in config1[11:0]. Define a mask
for it instead of hardcoded 0xFFF. Unlike "config" fields whose layout
maps to PERF_{FETCH|OP}_CTL MSR, layout of "config1" is custom defined
so a new set of macros are needed for "config1" fields.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20260216042530.1546-2-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c         | 11 +++++++----
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 32e6456..2e8fb06 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -32,6 +32,9 @@ static u32 ibs_caps;
 /* attr.config2 */
 #define IBS_SW_FILTER_MASK	1
=20
+/* attr.config1 */
+#define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
+
 /*
  * IBS states:
  *
@@ -274,7 +277,7 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ib=
s,
 {
 	return perf_ibs =3D=3D &perf_ibs_op &&
 	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
-	       (event->attr.config1 & 0xFFF);
+	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
 }
=20
 static int perf_ibs_init(struct perf_event *event)
@@ -352,13 +355,13 @@ static int perf_ibs_init(struct perf_event *event)
 	}
=20
 	if (perf_ibs_ldlat_event(perf_ibs, event)) {
-		u64 ldlat =3D event->attr.config1 & 0xFFF;
+		u64 ldlat =3D event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK;
=20
 		if (ldlat < 128 || ldlat > 2048)
 			return -EINVAL;
 		ldlat >>=3D 7;
=20
-		config |=3D (ldlat - 1) << 59;
+		config |=3D (ldlat - 1) << IBS_OP_LDLAT_THRSH_SHIFT;
=20
 		config |=3D IBS_OP_LDLAT_EN;
 		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
@@ -1305,7 +1308,7 @@ fail:
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <=3D (event->attr.config1 & 0xFFF)) {
+		    op_data3.dc_miss_lat <=3D (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_=
MASK)) {
 			throttle =3D perf_event_account_interrupt(event);
 			goto out;
 		}
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index ff5acb8..67ecb98 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -671,6 +671,7 @@ struct arch_pebs_cntr_header {
  */
 #define IBS_OP_LDLAT_EN		(1ULL<<63)
 #define IBS_OP_LDLAT_THRSH	(0xFULL<<59)
+#define IBS_OP_LDLAT_THRSH_SHIFT	(59)
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
 #define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)

