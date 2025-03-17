Return-Path: <linux-tip-commits+bounces-4270-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF21A64A9A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C3A3A4E26
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F624419B;
	Mon, 17 Mar 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u35b+bsY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozwUEbWB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781582417EF;
	Mon, 17 Mar 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207701; cv=none; b=AtV5yxhYrkhZPUKYcEPWLEXJci04TGlzNkC1vaTz+Ziz95yINLx5b6lZULbDJTLGsfnNPmVleioReN2dZGALf2lOwsE5x+fpivs5E5X2Hho5bv8oJDQjoWVFUB+7qNCxGj9YhyZr6V8A0W6XBO/OBf+SgQt19ATNHdJp+BeM13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207701; c=relaxed/simple;
	bh=PQ4m1BRysJtmQ91pV7uLzV57b8MNZUPVEtNJiCG++4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C+YKOmcq24N1r39zpWbYv1qk1ICm4eqi8aKqaoJPZIIHx5ReFcDz4hAuLQBJAYannSRUMopTOgfgzDZcOTEdUNb8ZxtNmua8zJa6bwjZhK3Phf9zDqxvGxitGQ2Ws6rSttEuMoA2nePDDfDfqPSUF1y+YtCec0p31eN11K8DVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u35b+bsY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozwUEbWB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+XbdGz1+FVQ/u6Y/RU8bJLvpnpYWbHXZ93xWZzLr/I=;
	b=u35b+bsYZDFxO82YvRdFGvCCB3wJOwdfInHHFZ+q6Lir09MryFh2Zrrqc31tG03rZIkf9S
	y2ncWsqYjIlJ5C3djt2vXpWcsFvTbokBxsdgTmXO3EQzpDloiA5TDsVXomppN8ZY6COG6q
	GwjEMHBaGYAKeKoQzEl8Uo30b0TV3jafOc6JsSwFo3G3UNFiv56EoArimQH0mq2dnIEPvb
	YbkFWjLCNDX4jC5m2hMmg+6z2FQ3Ez5EYi68rB2nfIy0NYG+ofI7zq+AMke3Uaq4yR5bFE
	i5Ke4t2Z6iRZ6QRPIG2F9yMI8KF2ZqpU51rnXOElUJRYqDQAJn2f8mBVGGK44g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+XbdGz1+FVQ/u6Y/RU8bJLvpnpYWbHXZ93xWZzLr/I=;
	b=ozwUEbWBVN4MfhV3jz1vJeKNUhONk1L5SGWkmiyeTa2kA6ZvczOjK9JC88RL/oBngZif/1
	IJ4P8rg0M/bRuIBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add a generic function to return the
 preemption string
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-2-bigeasy@linutronix.de>
References: <20250314160810.2373416-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220769709.14745.10741655509643439400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8bdc5daaa01e3054647d394d354762210ad88f17
Gitweb:        https://git.kernel.org/tip/8bdc5daaa01e3054647d394d354762210ad=
88f17
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:38 +01:00

sched: Add a generic function to return the preemption string

The individual architectures often add the preemption model to the begin
of the backtrace. This is the case on X86 or ARM64 for the "die" case
but not for regular warning. With the addition of DYNAMIC_PREEMPT for
PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
simultaneously. That means that everyone who tried to add that piece of
information gets it wrong for PREEMPT_RT because PREEMPT is checked
first.

Provide a generic function which returns the current scheduling model
considering LAZY preempt and the current state of PREEMPT_DYNAMIC.

The resulting strings are:
=E2=94=8F=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=B3=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=93
=E2=94=83   Model   =E2=94=83  -RT -DYN    =E2=94=83     +RT -DYN      =E2=94=
=83     -RT +DYN       =E2=94=83     +RT +DYN      =E2=94=83
=E2=94=A1=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=95=87=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=A9
=E2=94=82NONE       =E2=94=82 NONE         =E2=94=82 n/a               =E2=94=
=82 PREEMPT(none)      =E2=94=82 n/a               =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82VOLUNTARY  =E2=94=82 VOLUNTARY    =E2=94=82 n/a               =E2=94=
=82 PREEMPT(voluntary) =E2=94=82 n/a               =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82FULL       =E2=94=82 PREEMPT      =E2=94=82 PREEMPT_RT        =E2=94=
=82 PREEMPT(full)      =E2=94=82 PREEMPT_{RT,full} =E2=94=82
=E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
=E2=94=82LAZY       =E2=94=82 PREEMPT_LAZY =E2=94=82 PREEMPT_{RT,LAZY} =E2=94=
=82 PREEMPT(lazy)      =E2=94=82 PREEMPT_{RT,lazy} =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

[ The dynamic building of the string can lead to an empty string if the
  function is invoked simultaneously on two CPUs. ]

Co-developed-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Co-developed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20250314160810.2373416-2-bigeasy@linutronix.de
---
 include/linux/preempt.h |  2 ++-
 kernel/sched/core.c     | 47 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c    | 10 +++++----
 kernel/sched/sched.h    |  1 +-
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235..3e9808f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -515,6 +515,8 @@ static inline bool preempt_model_rt(void)
 	return IS_ENABLED(CONFIG_PREEMPT_RT);
 }
=20
+extern const char *preempt_model_str(void);
+
 /*
  * Does the preemption model allow non-cooperative preemption?
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03d7b63..c734724 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7646,10 +7646,57 @@ PREEMPT_MODEL_ACCESSOR(lazy);
=20
 #else /* !CONFIG_PREEMPT_DYNAMIC: */
=20
+#define preempt_dynamic_mode -1
+
 static inline void preempt_dynamic_init(void) { }
=20
 #endif /* CONFIG_PREEMPT_DYNAMIC */
=20
+const char *preempt_modes[] =3D {
+	"none", "voluntary", "full", "lazy", NULL,
+};
+
+const char *preempt_model_str(void)
+{
+	bool brace =3D IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		(IS_ENABLED(CONFIG_PREEMPT_DYNAMIC) ||
+		 IS_ENABLED(CONFIG_PREEMPT_LAZY));
+	static char buf[128];
+
+	if (IS_ENABLED(CONFIG_PREEMPT_BUILD)) {
+		struct seq_buf s;
+
+		seq_buf_init(&s, buf, sizeof(buf));
+		seq_buf_puts(&s, "PREEMPT");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			seq_buf_printf(&s, "%sRT%s",
+				       brace ? "_{" : "_",
+				       brace ? "," : "");
+
+		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
+			seq_buf_printf(&s, "(%s)%s",
+				       preempt_dynamic_mode > 0 ?
+				       preempt_modes[preempt_dynamic_mode] : "undef",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		if (IS_ENABLED(CONFIG_PREEMPT_LAZY)) {
+			seq_buf_printf(&s, "LAZY%s",
+				       brace ? "}" : "");
+			return seq_buf_str(&s);
+		}
+
+		return seq_buf_str(&s);
+	}
+
+	if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY_BUILD))
+		return "VOLUNTARY";
+
+	return "NONE";
+}
+
 int io_schedule_prepare(void)
 {
 	int old_iowait =3D current->in_iowait;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047ad..39be739 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -244,11 +244,13 @@ static ssize_t sched_dynamic_write(struct file *filp, c=
onst char __user *ubuf,
=20
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
-	static const char * preempt_modes[] =3D {
-		"none", "voluntary", "full", "lazy",
-	};
-	int j =3D ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_L=
AZY);
 	int i =3D IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
+	int j;
+
+	/* Count entries in NULL terminated preempt_modes */
+	for (j =3D 0; preempt_modes[j]; j++)
+		;
+	j -=3D !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
=20
 	for (; i < j; i++) {
 		if (preempt_dynamic_mode =3D=3D i)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0212a0c..e8915ad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3633,6 +3633,7 @@ extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
+extern const char *preempt_modes[];
=20
 #ifdef CONFIG_SCHED_MM_CID
=20

