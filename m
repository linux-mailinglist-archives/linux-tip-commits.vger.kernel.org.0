Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D625342C708
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Oct 2021 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbhJMQ7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Oct 2021 12:59:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:50943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238047AbhJMQ7f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Oct 2021 12:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634144237;
        bh=H0NVNpK0fftAT3BEIq4Q/VjiBME4Ggj1xdbyrhLlOkQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=LRr+HyzCtbWESFIv+4bu0tz/iCA4pq+eCcWDI9UNt9Akm+V7syl/N3UokJTupbtIc
         rQA2NyPnekrF6/jqJ7jUySP/9p8iauTKt6d4EAQyAvhtTUqvnp8MIgyP6X+FLuI9jO
         oxGvL7pHRBKIQk/nT2YDu295bG/o4V+wMHemL6Tc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.85]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1mILKo2zDv-00ITjh; Wed, 13
 Oct 2021 18:57:17 +0200
Message-ID: <16b0ac0a69615ecd3ae59b0c32161a0b26b8b3ca.camel@gmx.de>
Subject: Re: [tip: locking/core] futex: Split out requeue
From:   Mike Galbraith <efault@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org
Date:   Wed, 13 Oct 2021 18:57:15 +0200
In-Reply-To: <163377402732.25758.10591795748827044017.tip-bot2@tip-bot2>
References: <20210923171111.300673-14-andrealmeid@collabora.com>
         <163377402732.25758.10591795748827044017.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cza89XcjD9J4b/9j4noVjjK/fGwDE7SUc2IiAqxLAFgFrUiw9WW
 dqqJqmfyn5fLoDCmTcSAtjclacxTviWpmawRPfRZ/shiFM5gljWzNokShC/1ra4q9Fai6pq
 tcKPufTOX5EEnhWhjGijM2k1aY5Yk3EudcdN59YQ+aAMWcvTcSvBpS+OvxzSTLS64UcLB5a
 4MgKT4SJcqYk7FiT32kGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kAdNmo8vxGU=:G3gVttsKAvscRBZ8iyZ//M
 xqnl1WFlt5RGhf+dTA2q1YmiKZT2XAbzNpl852gE2Ej+WxznhVDryjgkf0wpxGdXP0qVQa7By
 sAac/TSmQgtWbWv6uSg6ejM7VhpckqVCfbubyx7jk0emYpwZzkZbUgmCzMe17ZZds72lZ8iDV
 BOzc1ctl/9ntQGEzxHKBcymbe1D9IgvFXQ4P7ayueFBqOdpRv1IBW2ng5WpTkKxz518GgqD7B
 +2hI4COI6Wx9CMEDQKcpMKjhN8XwxXSizjWtQW7p2DcpzbIWsJRHuF4Cewr7RqmYiSo6BEThY
 66yNbBLIYutHpCPJxJGOqSBzK/SrpGYV4woBLHJP0XuCzNNZWra8HjBUYAeOLnCctJYwmuCqE
 36TlHKW9P8LTycRj2nKtbk3r6jOIVdK4AnZAPR282njWwgjsoa5AM9MeY1eZ3P0E74CJia8u5
 4mgFQAN7EtcXLkGzG0bbPKLj3qrpWHAnZbh6PZ9ORT0v2MjZ4q6QHQTk2vVUkd+9EVAS+EfSc
 vZna7/JQTXrFF6A7ZbeBW5AgQBVRsjDP6oyk8MxSBzty+P3+8uFRxQv//7ZoVRFgIKwP7NbBj
 r4W56SxDvu6vlxfYzsRD0b5o3vWefDeEL+WMymkDo+sILxFJYRP1yDQIp7IulGcmO3qmvTU16
 HlkLk3BUG+N67iG/w4YMgJsUlyZjLb8VYYeRLkTTZdOY8evjHEcC+RShH/3SHQ0Vzb1H9Tan+
 jdDuYGgL5Bmc97TI5TSAmQU+NagVoz75eLzd5rpdCu7aP2ttJtTItEJHx4xtYYjvJPoYmLeds
 Uq1ju5QZ1j7tdXnO7FO/03wlhFV2LNfJJ4urOPpmDkEC8GoMsz5qW1eJKHwXpJyL1ucCSdA4w
 xod646pnKIWOa4lvINUUr5eoGW07TmwiZuKv3x8NBSEZgvmtuphJ2UqA0jBfmziTCPClV8js6
 FCWaaXEGNurqBg5LwijbNtZaXTCCIJDiFnjVVdqu0amIkq14avLtbWjvM4OIrgpXj6v8lC6e8
 P7clCUfo8f0JyOz+VGKFt7FrNCNqFi4Ly4P+DdgPqtqoe+UO34NMiG/RzARa5suZq7iFewJck
 GmbUuqLBt4lhQY=
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, 2021-10-09 at 10:07 +0000, tip-bot2 for Peter Zijlstra wrote:
>
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index 4969e96..840302a 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -3,6 +3,8 @@
> =C2=A0#define _FUTEX_H
> =C2=A0
> =C2=A0#include <linux/futex.h>
> +#include <linux/sched/wake_q.h>

+#ifdef CONFIG_PREEMPT_RT
+#include <linux/rcuwait.h>
+#endif

?

I needed that for tip-rt to build. It also boots, and futextests are
happy (whew, futexes hard).

	-Mike
