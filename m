Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899833EA8E4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhHLQ6x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 12:58:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59782 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbhHLQ6x (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 12:58:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628787506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62G4dU5wieVTwuTwkdkYbYBGIKJZ6MMqOVtxRJPIJYw=;
        b=fIa35NqWRwZjI7/9YAu6i+bf2Akd2/8CnMNsdzDuF4A4n/DlPsj6+8WU40wzMtu7L4o1M+
        ZOCe4X9y9KXqXm2KVav/ArozL/SN6poJrlN6cCKaYyFCQIFsy1p9d/HnSfE+JaQQbhG6wX
        9PD/+AWukZUOcKkUgCMXW50Lgr1BAbVtNQXbhQPzfCER/o+hY8y+6s6XHJBmihBHCsFVii
        4cJkwQC9HjHVJ4QfZklSa87OztsQ/sBbAwFIYhLHc0Z0TfHFG8pyp8ruQEx5Tu7QrixZrZ
        xLdEOR11A1KwRPpI6xpgt2Aom18Pv9QU96LW/2eGwZWLoRDAGmFDB1Nja0BNvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628787506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=62G4dU5wieVTwuTwkdkYbYBGIKJZ6MMqOVtxRJPIJYw=;
        b=s7R+9lBNyhtuoJ6c+4Zic/NWGqEHSgxnVP4wPmmCxGkBnN99vpjEuKqkjDIC728nnyaWUm
        ePDAUR0VClz/yRCA==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: timers/core] hrtimer: Consolidate reprogramming code
In-Reply-To: <e5f39aa65a0d7d72a414556eb0c182bb8dcd1691.camel@gmx.de>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx>
 <bc6b74396cd6b5a4eb32ff90bcc1cb059216e0f3.camel@gmx.de>
 <87v94ahemj.ffs@tglx>
 <e5f39aa65a0d7d72a414556eb0c182bb8dcd1691.camel@gmx.de>
Date:   Thu, 12 Aug 2021 18:58:26 +0200
Message-ID: <87pmuiha6l.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Aug 12 2021 at 17:31, Mike Galbraith wrote:
> On Thu, 2021-08-12 at 17:22 +0200, Thomas Gleixner wrote:
>> >
>> > Config attached just in case.
>>
>> I rather assume it's a hardware dependency. What kind of machine are you
>> using?
>
> Desktop box is a garden variety MEDION i4790 box with an Nvidia GTX980.
> Lappy is an HP Spectre 360 i5-6200U w. i915 graphics.  Very mundane.

Hmm, spectre induced timer meltdown? :)

Anyway I found a box which exposes the problem. Investigating...

Thanks,

        tglx
