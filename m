Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3340830A69B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Feb 2021 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBALd3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Feb 2021 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBALdO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Feb 2021 06:33:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C62C061756;
        Mon,  1 Feb 2021 03:32:34 -0800 (PST)
Date:   Mon, 01 Feb 2021 11:32:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612179152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4GT23TxHEUlhwzlC33uHhNDQHpZrF+//zTGD5d1pvo=;
        b=RBqZj7VYPe2XSlB6X462taM/0DC3Fu19YHXA+3virq21d/iEv6I2RitjA25HrM4ITQD/Rr
        rZiibodhAd9CBEut17E0eofAlBMl2+rN10u7Om06vVR5KSkCv7B8+28TodOYAecczo7jRj
        dC7qiYIdafXg3C/oBk+KqWEIrYEzpfeVR+CxJkIOabtJETYyUDLAZPKLREX9w1imGD+VUs
        aDI2oeo+CIKMFXaByofVrZjT7i/McvdpL69fuDDFL+YM4P3MS7e8bqwBLgXbacs4CRrfNP
        jkWegHkBaCQaw5sYq/7anHcYEv5m2LVwcOr0nTSW+S/4nKXvO4XfR13QTd/d3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612179152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4GT23TxHEUlhwzlC33uHhNDQHpZrF+//zTGD5d1pvo=;
        b=6bnnfif4SN4jM/0pmPe2mvHiIaqp0lnrzk315Cvq7Mfzo/fA+YjbBrNSTAryCUqAnq7L2o
        Q3vNQaYy3/x5uhAQ==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Remove empty rwsem.h
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210126101721.976027-1-nborisov@suse.com>
References: <20210126101721.976027-1-nborisov@suse.com>
MIME-Version: 1.0
Message-ID: <161217915118.23325.11846827701930657169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     442187f3c2de40bab13b8f9751b37925bede73b0
Gitweb:        https://git.kernel.org/tip/442187f3c2de40bab13b8f9751b37925bede73b0
Author:        Nikolay Borisov <nborisov@suse.com>
AuthorDate:    Tue, 26 Jan 2021 12:17:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Jan 2021 20:02:34 +01:00

locking/rwsem: Remove empty rwsem.h

This is a leftover from 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20210126101721.976027-1-nborisov@suse.com
---
 kernel/locking/rwsem.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 kernel/locking/rwsem.h

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
deleted file mode 100644
index e69de29..0000000
--- a/kernel/locking/rwsem.h
+++ /dev/null
