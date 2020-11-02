Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1372A2461
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Nov 2020 06:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgKBFiM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Nov 2020 00:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgKBFiM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Nov 2020 00:38:12 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA95C0617A6;
        Sun,  1 Nov 2020 21:38:12 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id z2so11823011ilh.11;
        Sun, 01 Nov 2020 21:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bPLW8Pb33mTsR143+WbKlCrEH4pZOBKjwtOQGjJ+H0=;
        b=UT2LY8wk3t/ZJpYVyjOJmucInrj9gg8gSLa2+FvH55HMbB/KZjQ0KivvpwWUImY8B0
         OWkiy9UBDk07EDSI8dsFiRHl6hS9bHAIkwBnF+DpXoJe2fvzLCPl9bSk6TGVpZuCCgfj
         79DhdqasMtBvGNcd7C6+Cf8baIE4a9rlDv5lF9/qypqRO9e71XnBuXS06RI5w1IhHXRv
         PQUQS1LDiSFXeJvtr87J09DiqrQL92TTa2Kf6Ua+Hgn9O2fx/PIaaceCVxopht+06Odj
         edd/IOqyruBV9xjX4doOmOXufeyqEtGQIuFzySXDuJRjnwDt4Dx/fc5wUP0WepxN2omR
         eK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bPLW8Pb33mTsR143+WbKlCrEH4pZOBKjwtOQGjJ+H0=;
        b=jVtX0rWVzM2Tovm7wsxo06Av+j1iys9wHPxVQmGos4SVnJXtl7vhFcaFz4BeWvtTBt
         eHgwR+l1jQLJZ9GT7K7xoSO7p2rkbiOZ6OZc+R6Ky7E9AhEcWYEt2erBg23ifGpFRfVB
         /yor+2+5ieoX5k01kUtDJG+NV+2qaOwbSyKEbvYAyH+JGVoFjLTOOk36raRtlBKrgPtV
         df3yHR/FfacNXwkUidaG4fZQtSm0R4/rNb3U49bfvC+LvBq9K3gvouEaZesPOtGiy1pj
         dmPcbgm0W2YS9BmgZvnDc4GwnFrPl2VtxZeBKzmNzfX9sqLMiLDoeOhbpFDhQVuNQSq8
         EXcA==
X-Gm-Message-State: AOAM531zqbZcPTN0kuttqJ/4pwI27RUAvPX2Evm2eYNuWeoQdaBIWc2E
        cLmCFGC+uuf7fDF7JENV1u8=
X-Google-Smtp-Source: ABdhPJyjN215y0CpZk+oo0tT4jqpjyIMDFstapXd5fvns8MZPkeTVqUDt//a4weMZNTQrVg2HmhHjA==
X-Received: by 2002:a92:5e55:: with SMTP id s82mr10065834ilb.48.1604295491795;
        Sun, 01 Nov 2020 21:38:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j10sm465312iop.34.2020.11.01.21.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 21:38:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9469827C0054;
        Mon,  2 Nov 2020 00:38:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 02 Nov 2020 00:38:10 -0500
X-ME-Sender: <xms:QpufX4D-eEb-ifAsIGqonj8wd7wXcB1-v3eqBifMzHt09Rm3I5ulaQ>
    <xme:QpufX6h4IZy--xnKF-hfUAtuC0RRQIgLO9wdqWg6KmQaK8J3isYv4fjSlhRXsY4Q3
    -cWgkPQEVfEA3r_Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddttddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepkeejkeekudekieevuedufefhudeiheevvddvtddtveffteegvdehueeltddu
    hfeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtuddrkeeirdegud
    drgeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunheppehfihigmhgvrdhnrghmvgesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:QpufX7mn52649JHwb28QJ4axAAFd8BWlwMhlaRv_1ctFNxkYAa6enw>
    <xmx:QpufX-wLwqr-Yfe1fj9d073aMv2GEQrSUSNBgFsNvktJvvYhqIyLww>
    <xmx:QpufX9TfKO1ZsW43vJN4FHX2GyPPF5U_Gm98_0UyM537sodDkj0Z-g>
    <xmx:QpufX2J5C451qX7DQkmF9qmjIzhUfhZpBMRAJvIwDnXXfCnGU0AJgA>
Received: from localhost (unknown [101.86.41.47])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60198306467D;
        Mon,  2 Nov 2020 00:38:08 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Qian Cai <cai@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] lockdep/selftest: Add spin_nest_lock test
Date:   Mon,  2 Nov 2020 13:37:42 +0800
Message-Id: <20201102053743.450459-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102053743.450459-1-boqun.feng@gmail.com>
References: <20201030093806.GA2628@hirez.programming.kicks-ass.net>
 <20201102053743.450459-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Add a self test case to test the behavior for the following case:

	lock(A);
	lock_nest_lock(C1, A);
	lock(B);
	lock_nest_lock(C2, A);

This is a reproducer for a problem[1] reported by Chris Wilson, and is
helpful to prevent this.

[1]: https://lore.kernel.org/lkml/160390684819.31966.12048967113267928793@build.alporthouse.com/

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
---
 lib/locking-selftest.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index afa7d4bb291f..4c24ac8a456c 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2009,6 +2009,19 @@ static void ww_test_spin_nest_unlocked(void)
 	U(A);
 }
 
+/* This is not a deadlock, because we have X1 to serialize Y1 and Y2 */
+static void ww_test_spin_nest_lock(void)
+{
+	spin_lock(&lock_X1);
+	spin_lock_nest_lock(&lock_Y1, &lock_X1);
+	spin_lock(&lock_A);
+	spin_lock_nest_lock(&lock_Y2, &lock_X1);
+	spin_unlock(&lock_A);
+	spin_unlock(&lock_Y2);
+	spin_unlock(&lock_Y1);
+	spin_unlock(&lock_X1);
+}
+
 static void ww_test_unneeded_slow(void)
 {
 	WWAI(&t);
@@ -2226,6 +2239,10 @@ static void ww_tests(void)
 	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
 	pr_cont("\n");
 
+	print_testname("spinlock nest test");
+	dotest(ww_test_spin_nest_lock, SUCCESS, LOCKTYPE_WW);
+	pr_cont("\n");
+
 	printk("  -----------------------------------------------------\n");
 	printk("                                 |block | try  |context|\n");
 	printk("  -----------------------------------------------------\n");
-- 
2.28.0

