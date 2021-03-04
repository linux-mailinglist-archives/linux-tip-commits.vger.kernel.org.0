Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3323A32D14C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhCDK6j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 05:58:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbhCDK6V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 05:58:21 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614855459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yU7nKv2xxiwOwNthg9CVnROsFvbEw5swN2tdMBE1Ks=;
        b=YqlSVXHcYiU8x7bIkwHzGeC4mg0j7fJused5tycVd90fcrA9tk5WtT6WClwvc+LCP7YapZ
        F0yKubuBzIfIK8jpRvskKVk64+hWfni+hGwo+U8HZoRGawzmNNlc5J3WkDBP37Qo+FBzP1
        bwapOwqU5FmwugqvIrmtH4/GK40Yc4adTPWroE3anXkvKqMiPlsx5JPJBm5IUTc3WGGQ5T
        wYfPlbmiOMoNSV2gsF45MzckuUjdYwX0z6/6A/wAvMyvO2T1KT0ATG22NJXVevzbKZSECd
        EPxz1ZLeG/JDz2RJoqDp0QEIBEvYYQ8oP+x0nNOe7fEGjzXjyEjPR4g0WcwQqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614855459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yU7nKv2xxiwOwNthg9CVnROsFvbEw5swN2tdMBE1Ks=;
        b=Ikk67V0NAANBFo88YOq5GuslctliZWmirgADu1VvljbVXCza1uwJMjQy7LU/zi4PtC9BqR
        0gYJPv0PrB/WKcBQ==
To:     tip-bot2 for Barry Song <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>, dmitry.torokhov@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()
In-Reply-To: <161485523394.398.10007682711343433706.tip-bot2@tip-bot2>
References: <20210302224916.13980-2-song.bao.hua@hisilicon.com> <161485523394.398.10007682711343433706.tip-bot2@tip-bot2>
Date:   Thu, 04 Mar 2021 11:57:39 +0100
Message-ID: <87zgzj5gpo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Dmitry,

On Thu, Mar 04 2021 at 10:53, tip-bot wrote:

> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID:     e749df1bbd23f4472082210650514548d8a39e9b
> Gitweb:        https://git.kernel.org/tip/e749df1bbd23f4472082210650514548d8a39e9b
> Author:        Barry Song <song.bao.hua@hisilicon.com>
> AuthorDate:    Wed, 03 Mar 2021 11:49:15 +13:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 04 Mar 2021 11:47:52 +01:00
>
> genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()

this commit is immutable and I tagged it so you can pull it into your
tree to add the input changes on top:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-no-autoen-2021-03-04

Thanks,

        tglx
